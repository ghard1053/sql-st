-- self join

select P1.name as name_1, P2.name as name_2
  from Products P1 cross join Products P2;

select P1.name as name_1, P2.name as name_2
  from Products P1 inner join Products P2
    on P1.name <> P2.name;

select P1.name as name_1, P2.name as name_2
  from Products P1 inner join Products P2
    on P1.name > P2.name;

select P1.name as name_1,
       P2.name as name_2,
       P3.name as name_3
  from Products P1
    inner join Products P2
      on P1.name > P2.name
        inner join Products P3
          on P2.name > P3.name;


delete from Products P1
  where rowid < ( select max(P2.rowid)
                    from Products P2
                    where P1.name = P2.name
                    and P1.price = p2.price);