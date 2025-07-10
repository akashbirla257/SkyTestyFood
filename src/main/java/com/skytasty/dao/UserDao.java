package com.skytasty.dao;

import com.skytasty.model.Role;
import com.skytasty.model.User;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate5.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class UserDao {
    @Autowired
    private HibernateTemplate hibernateTemplate;

    @Transactional
    public void saveUser(User user) {
        hibernateTemplate.saveOrUpdate(user);
    }

    public User getUserById(int id) {
        return hibernateTemplate.get(User.class, id);
    }

    public User getUserByUsername(String username) {
        List<User> users = (List<User>) hibernateTemplate.getSessionFactory()
                .getCurrentSession()
                .createQuery("FROM User WHERE username = :username", User.class)
                .setParameter("username", username)
                .list();
        return users.isEmpty() ? null : users.get(0);
    }

    @Transactional
    public void deleteUser(int id) {
        User user = getUserById(id);
        if (user != null) {
            hibernateTemplate.delete(user);
        }
    }

    public List<User> getAllUsers() {
        return (List<User>) hibernateTemplate.find("FROM User");
    }

    @Transactional
    public void saveRole(Role role) {
        hibernateTemplate.saveOrUpdate(role);
    }

    public Role getRoleByName(String roleName) {
        return hibernateTemplate.execute(session -> {
            Query<Role> query = session.createQuery("FROM com.skytasty.model.Role WHERE name = :name", Role.class)
                    .setParameter("name", roleName);
            return query.uniqueResult();
        });
    }
}