package springProject.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import springProject.dao.TaskDAO;
import springProject.entity.Task;

import java.time.LocalDate;
import java.util.Arrays;

@Controller
public class HomeController {

    @Autowired
    TaskDAO taskDAO;

    @RequestMapping({"/", "/home"})
    public String home(Model model) {
        model.addAttribute("taskList", taskDAO.selectAll());
        System.out.println(taskDAO.selectAll());
        return "home";
    }

    @RequestMapping("/filter")
    public String filterData(
            @RequestParam("name") String name,
            @RequestParam("from") String from,
            @RequestParam("to") String to,
            @RequestParam("is comp") String completed,
            Model model) {
        model.addAttribute("taskList", taskDAO.filter(name, from, to, completed));
        return "home";
    }

    @GetMapping("/add")
    public String saveTask(@RequestParam("name") String name,
                           @RequestParam("description") String description,
                           @RequestParam("deadline") String deadline,
                           Model model) {
        int [] date = Arrays.stream(deadline.split("-"))
                .mapToInt(Integer::parseInt)
                .toArray();
        taskDAO.add(new Task(name, description, LocalDate.of(date[0], date[1], date[2])));
        model.addAttribute("taskList", taskDAO.selectAll());
        return "home";
    }

    @RequestMapping("/processTask")
    public String process(@RequestParam("id") Integer id, Model model){
        model.addAttribute("task", taskDAO.getTaskById(id));
        return "updateTask";
    }

    @RequestMapping("/update")
    public String updateTask(@RequestParam("id") Integer id,
                             @RequestParam("name") String name,
                             @RequestParam("description") String description,
                             @RequestParam("deadline") String deadline,
                             @RequestParam("compl") String compl,
                             Model model) {
//        System.out.println(compl.equals("YES"));
        int [] date = Arrays.stream(deadline.split("-"))
                .mapToInt(Integer::parseInt)
                .toArray();

        taskDAO.update(id, compl.equals("YES"),new Task(name,
                description,
                LocalDate.of(date[0], date[1], date[2])));
        model.addAttribute("taskList", taskDAO.selectAll());
        return "home";
    }

    @GetMapping("/delete")
    public String deleteTask(@RequestParam("id") Integer id,
                             Model model) {
        taskDAO.delete(id);
        model.addAttribute("taskList", taskDAO.selectAll());
        return "home";
    }
}
