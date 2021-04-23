package springProject.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import springProject.entity.Task;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import java.util.List;

@Repository
public class TaskDAO {

    @Autowired
    private  SessionFactory sessionFactory;

    // get list of all Tasks
    @Transactional
    public List<Task> selectAll() {
        Session session = sessionFactory.getCurrentSession();
        CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
        CriteriaQuery<Task> criteriaQuery = criteriaBuilder.createQuery(Task.class);
        Root<Task> root = criteriaQuery.from(Task.class);
        criteriaQuery.select(root);
        Query query = session.createQuery(criteriaQuery);
        return query.getResultList();
    }

    // get list of all filtered tasks
    @Transactional
    public List<Task> filter(String name, String from, String to, String completed) {
        Session session = sessionFactory.getCurrentSession();
        return session.createQuery("FROM Task t WHERE " +
                ("".equals(name) ? "" : " t.name = '" + name + "' and") +
                ("".equals(to) ? "" : " t.deadline <= '" + to + "' and") +
                ("".equals(from) ? "" : " t.deadline >= '" + from + "' and") +
                " t.completed = " + completed.equals("YES")).getResultList();
    }

    @Transactional
    public Task getTaskById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return session.get(Task.class, (long)id);
    }

    // add task to table
    @Transactional
    public void add(Task task) {
        Session session = sessionFactory.getCurrentSession();
        session.save(task);
    }

    // udpate data by id
    @Transactional
    public void update(int id, boolean completed, Task tempTask) {
        Session session = sessionFactory.getCurrentSession();

        Task task = session.get(Task.class, (long)id);

        task.setName(tempTask.getName());
        task.setDescription(tempTask.getDescription());
        task.setDeadline(tempTask.getDeadline());
        task.setCompleted(completed);
    }

    // delete data by id
    @Transactional
    public void delete(int id) {
        Session session = sessionFactory.getCurrentSession();
        Task task = session.byId(Task.class).load((long)id);
        session.delete(task);
    }
}
