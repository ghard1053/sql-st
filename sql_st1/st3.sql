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

select distinct A1.name, A1.address
  from Addresses A1 inner join Addresses A2
  on A1.family_id = A2.family_id
  and A1.address <> A2.address;

select distinct p1.name, p1.price
  from Products p1 inner join Products p2
  on p1.price = p2.price
  and p1.name <> p2.name
  order by p1.price;