# Java面试汇总

## 一.Static(静态)关键字
    Static用于修饰成员（成员变量和成员函数）
    被修饰后的成员具备一下特点：
    1.随着类的加载而加载（既然被静态修饰的数据要被对象所共享，所以它必须在对象创建之前就要加载完成，随着类的加载就已经在内存中进行了空间的分配，随着
    类的消失而消失）
    2.优先于对象存在  
    3.被所有对象所共享 
    4.可以直接被类名调用（没有对象也可以被调用，只有类可以完成这个调用动作，所以静态成员多了一种调用方式   类名.静态成员）
    5.被静态修饰的成员变量和成员函数在方法区中（以便共享）
    使用注意：
    1.静态方法只能访问静态成员,不能调用非静态成员。（因为非静态的成员只有在创建对象时才在内存中的存在，而静态的方法在对象创建之前就要出现在内存中）先       来后到  前面不能访问后面的  后面可以访问前面的非静态方法可以调用静态成员，也可以调用非静态成员。
    2.静态方法中不可以写this，super关键字    this代表对象，而静态方法执行时还没有对象呢。
    3.主函数是静态的
    当产生很多对象的时候，每个对象都是属性的封装体
    就拿这个例子来说，当创建很多个不同的人对象的时候，姓名name的值是不一样的，但是国家的值都相同，也就意味着生成多少个对象，堆内存中就得出现对少个 
    CN(特别浪费空间)
    相同的值在N多对象中出现，对空间而言就是一种浪费，这个时候就用到了静态（你想把一些数据从对象中提取出来，就可以用static关键字静态）
    这样就可以为所有的对象所共享  就在这个数据前面加上一个静态修饰符  static
    注意区分：静态成员变量和非静态成员变量：
    1.非静态成员变量又称为实例变量 静态成员变量又称为类变量
    2.非静态成员变量，随着对象的创建而存在，随着对象的消失而消失静态成员变量，随着类的加载而加载，随着类的消失而消失
    3.非静态成员变量存在于对象堆内存中   静态成员变量存在于方法区中
    4.非静态成员变量只能被对象所调用  静态变量可以被类名调用，也可以被对象调用。
    创建对象之前会加载类，静态初始化块会随着类的加载而加载，对整个类进行初始化，而且子类会先执行顶层父类的静态初始化块后才是子类静态初始化块，创建对     象时现执行父类行初始化代码块然后执行构造函数，然后执行子类的行初始化代码块之后才是子类的构造函数。
    (构造代码块之所以在构造函数之前运行是因为，构造代码块要对所有对象进行初始化，静态代码块是对类进行初始化)
## 二.继承（extends）
    好处：提高了代码的复用性，让类与类之间产生了关系。
         将对象中的共性内容不断的向上抽取就形成了关系，就有了继承，有了子父类提高了代码的复用。
    特点：只能单继承，多继承的机制被java语言改良了。
    单继承：一个类只能有一个父类。一个儿子只能有个父亲
    多继承：一个类可以有多个父类。一个儿子有多个父亲
    Java不直接支持多继承：原因：会产生调用的不确定性。
    Java支持多层继承。这样就出现了继承体系。
    继承中成员函数的特点：当子夫类中出现一模一样的方法时，会发生一个函数的特性：覆盖（复写，重写）override
    覆盖注意事项：
    1，子类覆盖父类时，必须要保证覆盖方法的权限大于等于被覆盖方法的权限
    2，覆盖方法有静态修饰时，静态只能覆盖静态，或者被静态覆盖，在写法上注意这个事项
    3，构造函数
    子类的实例化过程：
        其实在子类的所有构造函数中的第一行，默认都有一条隐式的语句。就是super(),也就是说子类的构造函数默认都会访问父类中空参数的构造函数。
    为什么子类的构造函数都要去默认访问父类的构造函数呢？
        因为子类继承了父类，可以访问父类中已有的一些属性。在子类进行实例化的时候必须要为父类中的属性分配空间。并要进行初始化，所以必须要访问一次父类         的构造函数，看看父类是如何对其属性 进行初始化的。所以子类在实例化对象时，必须要先看父类的初始化过程。
    结论：父类的构造函数既可以对本类对象进行初始化，也可以对子类对象进行初始化。
    注意：如果父类中没有空参的构造函数，子类的构造函数中必须手动用super指定要访问的父类中的构造函数。或者用this()来访问本类中的构造函数。
    this和super调用构造函数只能定义在构造函数的第一行，不能同时出现
    子类中的构造函数中要么只有this(),要么只有super(),不允许同时存在
    为什么要定义在第一行？因为初始化的动作要先完成，不初始化，用不了。
    继承弊端：打破了封装性
    解决方法，关键字final
## 三.final关键字的特点：
    1，final是一个修饰符，既可以修饰类，又可以修饰方法，开可以修饰变量（什么便来给你都包含）。
    2，final修饰的类不可以被继承。
    3，final修饰的方法不可以被覆盖。
    4，final修饰的变量是一个常量，只能赋值一次。
    为了将固定的一些数据方便使用，会给这些数据起一个容易阅读的名称，为了防止该名称存储的数据改变，用final修饰一般被final修饰的变量名称都是大写字母组     成，如果有多个单词每个单词之间用下划线分割。在开发时，一旦程序中出现固定的数据，一定要将其用一个容易阅读的名称存储，并用final修饰。
## 四.一个对象在内存中的产生过程：
    1.将该对象所需的类文件加载进内存
    2.在内存中进行方法区的空间分配
    3.通过new在对内存中开辟空间
    4.对象中的属性进行默认初始化
    5.调用与之对应的构造函数进行初始化
    6.通过构造函数中的super调用父类中的构造函数初始化
    7.对象中的属性进行显示初始化
    8.构造代码块初始化
    9.该构造函数内部自定义内容进行初始化。
## 五.抽象类
    当描述事物时，没有足够的信息对该事物进行描述，那么该描述对应的类就是一个抽象类。
    抽象类的特点：
    1.没有方法体的方法是抽象方法，一定定义在抽象类中。
    2.抽象类和抽象方法必须用abstract关键字修饰。
    3.抽象类不可以被实例化。为啥呢？因为调用抽象方法没有意义
    4.抽象类必须由其子类覆盖掉所有的抽象方法后，其子类才可以进行实例化，否则该子类还是一个抽象类。
    细节问题
    1.抽象类一定是个父类？是
    2.抽象类是否有构造函数？有，因为是给子类对象提供初始化动作的。
    3.抽象类是否可以不定义抽象方法？可以的，就是不让该类创建对象。这种情况在java的体系中就有存在，windowAdapter
    4.抽象关键字不能和那些关键字共存？
      非法的修饰符组合final:private:static:说明不需要用对象调用
    一般类和抽象类有什么异同呢？
    相同之处：一般类和抽象类都用于描述事物，里面都可以定义属性和行为，以及构造函数。
    不同之处：
    一般类中不可以定义抽象函数，抽象类可以，
    一般类可以被实例化，抽象类不可以。
    一般类可以被继承，也可以不被继承，
    抽象类一定要被继承，需要其子类覆盖所有的抽象方法子类才可以被实例化。
## 六.接口：
    当一个抽象类中全都是抽象方法的时候，这时，可以将抽象类定义成接口。
    接口是一个特殊的抽象类，意味着抽象类中的方法都是抽象方法。
    接口中不能定义变量，只能定义常量。
    接口中的成员都有固定的修饰符。（接口中不存在着构造函数）
    1.常量：   有固定的修饰符  public  static  final  全局常量。
    2.抽象方法 有固定的修饰符  public  abstract  
## 七.集合框架
    集合类的由来：对象用于封装数据，对象多了需要存储，如果对象的个数不确定。就使用集合容器进行存储。
    集合特点：
    1.用于存储对象的容器。
    2.集合的长度是可变的。
    3.集合中不可以存储基本数据类型值。
    集合容器因为内部的数据结构不同，有多种具体容器。不断的向上抽取，就形成了集合框架。
    框架的顶层Collection接口：
    Collection常见的方法：
     1.添加：
     boolean add(Object obj);
     boolean addAll(Collection coll);
     2.删除：
     boolean remove(Object obj);
     boolean removeAll(Collection coll);
     void clear();清空
    3.判断：
     boolean contains(Object obj);
     boolean containsAll(Collection coll);
     boolean isEmpty();判断集合是否有元素
     4.获取：
     int size();
     Iterator iterator();迭代器    取出集合中元素的方式  该对象必须依赖于具体的容器，因为每一个容器的数据结构都不一样 
     所以该迭代器对象是在容器中进行内部实现的。对于使用容器者而言，具体的实现不重要，只要通过容器获取到该实现的迭代器的对象即可  也就是iterator方
     法。Iterator接口就是对所有的Collection容器进行元素取出的公共接口。其实就是抓娃娃机中的夹子  
     5.其他：
     boolean retainAll(Collection coll);取交集。
     Object[] toArray();将集合转成数组。
     Collection
        |--List:有序(存入和取出的顺序一致)，元素都有索引（角标），元素可以重复。
        |--Set: 元素不能重复，无序。(有可能会有序)
     List：特有的常见方法：  有一个共性特点就是都可以操作角标
       1.添加
       void add(index,element);
       void add(index,collection);
       2.删除
       Object remove(index);
       3.修改
       Object set(index,element);
       4.获取：
       Object get(index);
       int indexOf(object);
       int lastIndexOf(object);
       List subList(from,to);
       List集合是可以完成对元素的增删改查。
       List:
          |--Vector:内部是数组数据结构。是同步的（线程安全）(几乎不用了)  增删查询都很慢 ！   百分之百延长
          |--ArrayList:内部是数组数据结构，是不同步的。替代了Vector   查询的速度块   百分之五十延长
          |--LinkedList:内部是链表数据结构，是不同步的。增删元素的速度很快。
      LinkedList：
         addFirst();
         addLast();
         offerFirst();
         offerLast();
         getFirst();//获取但不移除，如果链表为空，抛出NoSuchElementException
         getLast();
         peekFirst();//获取但不移除，如果链表为空，返回null.
         peekLast();
         removeFirst();//获取并移除，如果链表为空，抛出NoSuchElementException
         removeLast();
         pollFirst();//获取并移除，如果链表为空，返回null.
         pollLast();
    Set:元素不可以重复，是无序
    Set接口中方法和Collection一致
         |--HashSet:内部数据结构是哈希表，是不同步的。
         |--TreeSet:可以对Set集合中的元素进行排序。是不同步的。
         判断元素唯一性的方式：就是根据比较方法的返回值是否是0，是0，就是相同元素。
         TreeSet对元素进行排序的方式一：
          让元素自身具备比较功能，于是就需要实现Comparable接口。覆盖compareTo方法。如果不要按照对象中具备的自然顺序进行排序。
          如果对象中不具备自然顺序。可以使用TreeSet集合的第二种排序方式二：让集合自身具备比较功能，定义一个类实现Comparator接口，覆盖compare方法。           将该类对象作为参数传递给TreeSet集合的构造函数。
          哈希表确定元素是否相同：
          1.判断的是两个元素的哈希值是否相同。
            如果相同，再判断两个对象的内容是否相同
          2.判断哈希值相同，其实判断的是对象的hashCode的方法，判断内容相同，用的是equals方法
          注意：如果哈希值不同，是不需要判断equals的
          第一次判断： 哈希值相同不一定是同一个元素
          第二次判断：如果哈希值相同之后，再判断内容

Map:一次添加一对元素。Collection 一次添加一个元素。
Map也称为双列集合，Collection集合称为单列集合。
其实Map集合中存储的就是键值对。
 Map集合中必须保证键的唯一性。
常用方法：
1.添加
    value put(key,value)：返回前一个和key关联的值，如果没有返回null.
2.删除
    void  clear();清空Map结合
    value remove(key):根据指定的key删除这个键值对。
3.判断
    boolean containsKey(key);
    boolean containsValue(value);
    boolean isEmpty();
4.获取
  value get(key):通过键获取值，如果没有该键，返回null.当然可以通过返回null,来判断是否包含只当键。
  int size():获取键值对的个数。
Map常用的子类：
     |---HashTable:内部结构是哈希表，是同步的。不允许null作为值，不允许null作为键。
  Properties：用来存储键值对型的配置文件信息。可以和IO技术相结合。
     |---HashMap：内部结构是哈希表，不是同步的。允许null作为值，允许null作为键。
     |---TreeMap：内部结构是二叉树，不是同步的，可以对Map集合中的键进行排序。
泛型
  jdk1.5出现的安全机制
好处
  1.将运行 时期的安全问题ClassCastException转到了编译时期
  2.避免了强制转换的麻烦.
  3.编译时期的安全技术
<>:什么时候用?当操作引用数据类型不确定的时候.就使用<>.
   将要操作的引用数据类型传入即可
 其实<>就是一个用于接收具体引用数据类型的参数范围.
 在程序中,只要用到了带有<>的类或者接口,就要明确传入的具体引用数据类型.
泛型技术是给编译器使用的技术,用于编译时期,确保了类型的安全.
擦除补偿
运行时,会将泛型去掉,生成的class文件中是不带着泛型的,这个称为泛型的擦除.

为什么擦除,因为为了兼容运行时的类加载器.只在编译器中加入了泛型技术
泛型的补偿:在运行时,通过获取元素的类型进行转换动作.不用使用者再强制转换了.
泛型的通配符: ? 未知类型
=============================================
集合的一些技巧
    
     需要唯一吗？
     需要：set
                 需要指定顺序吗？
                 需要：TreeSet
                不需要:HashSet
                但是想要一个和存储一致的顺序（有序）：LinkedHashSet
     
     不需要：List
                需要频繁增删吗？
                    需要：LinedList
                    不需要：ArrayList
                                     
如何记住每一个容器的结构和所属体系呢？
  看名字！
  List
     ArrayList
     LinkedList
  Set
     HashSet
     TreeSet
后缀名就是该集合所属的体系
前缀名就是该集合的数据结构
看到Array就要想到数组，就要想到查询快，有角标
看到Link就要想到链表，就要想到增删块，就要想到add,get ,remove+first last方法
看到Hash就要想到Hash表，就要想到唯一性，就要想到元素需要覆盖hashCode方法和equals方法
看到Tree就要想到二叉树，就要想到排序，就要想到两个接口Comparable，Comparator。
Comparator和Comparable的区别?
Comparable 接口用于定义对象的自然顺序，而 comparator 通常用于定义用户定制的顺序。Comparable 总是只有一个，但是可以有多个 comparator 来定义对象的顺序。

而且通常这些常用的集合容器都是不同步的。
JDK1.8数据存储容器实现类介绍
编辑 
      这篇主要介绍jdk1.8的一些容器实现类(集合+映射(map))的作用和线程安全与否以及实现线程安全的方式，因为jdk提供的集合类挺多的，所以篇幅有些长，大家可以跳常用的几个看如ArrayList、HashMap、ConcurrentHashMap等。
特殊词汇说明：
1）cas操作：Compare and Swap或者Compare and Set，比较并操作，CPU指令，在大多数处理器架构，包括IA32、Space中采用的都是CAS指令，CAS的语义是“我认为V的值应该为A，如果是，那么将V的值更新为B，否则不修改并告诉V的值实际为多少”，CAS是项乐观锁技术，当多个线程尝试使用CAS同时更新同一个变量时，只有其中一个线程能更新变量的值，而其它线程都失败，失败的线程并不会被挂起，而是被告知这次竞争中失败，并可以再次尝试。CAS有3个操作数，内存值V，旧的预期值A，要修改的新值B。当且仅当预期值A和内存值V相同时，将内存值V修改为B，否则什么都不做。
2）DCL: 也就是Double Check Lock，双重检查锁定，解决jmm当初给某一引用赋值时先分配内存然后就赋值该内存地址在执行初始化方法的漏洞，其实jdk1.8后的集合许多实现是多重检查机制，防止在无锁情况下并发问题。
3）happen-before原则: 它是判断数据是否存在竞争、线程是否安全的主要依据，依靠这个原则，我们解决在并发环境下两操作之间是否可能存在冲突的所有问题,它的规则是jvm进行指令重排的依据之一。它的原则如下：
1. 如果一个操作happens-before另一个操作，那么第一个操作的执行结果将对第二个操作可见，而且第一个操作的执行顺序排在第二个操作之前。
2. 两个操作之间存在happens-before关系，并不意味着一定要按照happens-before原则制定的顺序来执行。如果重排序之后的执行结果与按照happens-before关系来执行的结果一致，那么这种重排序并不非法。
它的规则是(前4):
1.程序次序规则：一个线程内，按照代码顺序，书写在前面的操作先行发生于书写在后面的操作；
2.锁定规则：一个unLock操作先行发生于后面对同一个锁额lock操作；
3.volatile变量规则：对一个变量的写操作先行发生于后面对这个变量的读操作；
4.传递规则：如果操作A先行发生于操作B，而操作B又先行发生于操作C，则可以得出操作A先行发生于操作C；
4）Spliterator: Spliterator是一个可分割迭代器(splitable iterator),是jdk1.8后对集合优化的一个亮点，之前的iterator是顺序遍历迭代器，只能单线程的一个个元素的遍历这个集合，而Spliterator就是为了并行遍历元素而设计的一个迭代器，充分利用现代CPU多核的计算能力。

JDK提供的集合类型主要分四种类型：
(1)List  支持null元素和重复元素的动态扩容列表,jdk提供的实现类有：ArrayList, LinkedList, Stack,CopyOnWriteArrayList、Vector
 (2)Set 不支持重复元素的动态扩容列表,jdk提供的实现类有：EnumSet, TreeSet, HashSet, LinkedHashSet、 NavigableSet、ConcurrentSkipListSet、CopyOnWriteArraySet
(3)map  是存储键/值对的映射集，jdk提供的实现类有：HashMap, TreeMap,LinkedHashMap、ConcurrentHashMap、HashTable、ConcurrentSkipListMap
(4)queue/deque  queue是在集合尾部添加元素，在头部删除元素的队列，deque是可在头部和尾部添加或者删除元素的双端队列，
jdk提供的实现类有：ArrayDeque、 PriorityQueue、LinkedBlockingDeque、LinkedBlockingQueue、PriorityBlockingQueue、ArrayBlockingQueue、ConcurrentLinkedDeque、ConcurrentLinkedQueue

接下来介绍下具体这些容器实现类：
List
线程不安全的子类：
ArrayList, LinkedList,
ArrayList类简介：
是一个容量动态扩张的集合，实现了RandomAccess接口，支持随机访问，初始容量10，最大容量Integer.MAX_VALUE - 8（2147483640），每次调用ArrayList的新增或者删除等修改方法，继承自AbstactList抽象类的属性modCount都会自增，当通过Interactor遍历集合时，只要modCount被其他线程修改，就会抛出ConcurrentModificationException。ArrayList是线程不安全的类，因为它的操作自身集合属性的方法没有进行同步也不是原子性操作，所以会出现不一致现象，可以通过List list = Collections.synchronizedList(new ArrayList(...))把它转成线程安全的集合，当然只是封装了对ArrayList的操作，保存同步而已，性能不是很高，所有的修改操作都要一个个同步。
jdk1.8后支持Spliterator迭代器。
LinkedList类简介：
LinkedList内部是链表结果，非线程安全，修改链表结构的操作需要进行同步，如何有线程在用Interator遍历，而有线程在修改链表，会引发fast-fail，及Interator会抛出ConcurrentModificationException,可以使用Collections.synchronizedList方法来包装它。
添加元素的方法只是新增一个节点然后改变尾部节点和新增节点的引用链接，所以新增和删除操作比较快，但是不支持随机访问，判断某个值是否存在的方法contains(Object o)需要从第一个元素开始遍历到符合条件的元素止，效率不是很高。
LinkedList同时实现List和Deque接口，所以即可以当一个双端队列使用，也可以当List使用。
jdk1.8后支持Spliterator迭代器。
线程安全的子类:
CopyOnWriteArrayList、Vector，stack
CopyOnWriteArrayList简介：
CopyOnWriteArrayList实现了List接口，是线程安全的List，主要通过三个关键点来包装线程安全：
1）修改方法（add、set、remove等）都通过集合属性一个ReentrantLock进行同步，先获取锁，才能执行变更操作。但是通过ReentrantLock进行同步只是能保证线程的安全，并不能保持时间上的有序和正确，因为先申请锁然后进入休眠等待的线程，并不一定是最先获取锁的线程，所以，会在时间顺序看，对集合的修改是无序的。
2）对象数组用volatile修饰，其他线程对集合元素数组的修改，能够在其他线程的每次访问都是最新值。volatile如何影响线程栈读取内存变量，下一篇会单独说。
3）在对集合元素数组进行修改时，是先拷贝之前的元素数组出一个新元素数组，在新的元素数组上进行修改，修改完毕后在用元素数组替换旧的元素
数组，这样的内存消耗很大。第一个点已经说了修改集合元素的方法都加了锁，为什么这里获取锁后对集合元素的修改，还要通过拷贝数组的方式？因为拷贝出来的新数据修改完毕后赋予CopyOnwriteArrayList,数据存储的对象数组地址就更改了，已经创建的Interator对对象的数组的引用因为是final修饰的，所以还用的是旧的对象数组地址，所以这样就可以保证已经创建的Interator不受其他线程修改操作的影响。
jdk1.8后支持Spliterator迭代器。
Vector简介：
Vector是实现了List接口和RandomAccess接口的集合类，相对线程安全的，意思是多个线程同时对Vector的同一个修改方法进行操作是安全的，因为Vector对修改数据存储结构的方法如(add、romove)都加了syncronize进行同步。但是如何一个线程创建了Iterator，并进行遍历，那么另一个线程对Vector数据存储的修改都会让Iterator抛出ConcurrentModificationException异常。如果创建Vector实例时不指定每次扩容大小，默认为当下容量的两倍。
jdk1.8后支持Spliterator迭代器。
Stack简介:
stack是一个先进后出的集合，继承自Vecoter类，所以包含不属于栈操作insert和remove，它是线程安全的，因为stack自身的pop、peek、search是用synchronized修饰的同步方法，而Push是自己调用线程安全的vector的addElement方法。Stack是没有In
如果在想使用先进后出这种数据集合的话，建议使用ConcurrentLinkedDeque，在一端插入和删除元素，性能会比Stack好，因为它的同步策略是通过CAS和多重检查机制的无锁策略，比Stack这种在方法前加synchronized进行同步的要高效。

 
set
线程不安全的子类：
EnumSet, TreeSet, HashSet, LinkedHashSet、 NavigableSet
EnumSet简介：
EnumSet是枚举类的容器，是一个抽象类，非线程安全，内部提供静态方法noneOf(Enum.class clazz)来创建一个实现了继承自EnumSet类的实例，如果要装载的枚举类值不超过64个，则创建的是RegularEnumSet实例，如果超过64位，则创建的是JumboEnumSet。
RegularEnumSet内部通过Bit数组来存放枚举值，而这个Bit数组其实就是一个Long类型数值，初试时是0L，添加元素时，是把对应枚举元素的ordinal（每一个枚举类的枚举值都对应一个ordinal值）值映射到64Bit上的某一个位置为1。因为Set是不能重复的，所以RegularEnumSet最多存64个元素,RegularEnumSet的add方法源码如下：
    public boolean add(E e) {
        typeCheck(e);
        long oldElements = elements;
        elements |= (1L << ((Enum<?>)e).ordinal());
        return elements != oldElements;
    }
JumboEnumSet内部则通过long数组类存放枚举值，所以可以存放远远大于64个元素，当然枚举值太多也没有意义。
TreeSet简介：
treeSet是有序集合，内部通过TreeMap来存储元素，把元素存储在map的key里，通过TreeMap存储Key的有序性和无重复性来实现自己的有序性和Set的的元素无重复性；插入元素时，会根据元素的equals和compareTo方法判断大小，然后进行排序，但也只是插入的时候会进行排序，插入后修改顺序不改变。
TreeSet不是线程安全的，如何有多个线程访问TreeSet并至少有一个线程修改它的话，应该进行操作同步或者通过Collections.synchronizedSortedSet方法来创建一个包装TreeSet的线程安全的有序Set，如：SortedSet s = Collections.synchronizedSortedSet(new TreeSet(...));
jdk1.8后支持Spliterator迭代器。
HashSet简介：
允许null元素，没有实现RandomAccess接口，所以不支持随机访问，需要通过Interator进行遍历。它的内部存储是存储在一个内部属性HashMap的key里，因此它的性能深受两个参数initialCapacity, loadFactor的影响，一个是初始容量，一个是负载因子，这两个参数是作用于hashMap的，因此HashSet的初始大小不要设置太大，不然它的Interator会遍历完HashMap里存储元素的数组，不管是空和还是有元素存着，因为HashMap存储元素是根据hashCode做转换得到具体数组下标位置，会分散在整个存储数组，所以Interator遍历次数等于容量大小加上hash碰撞的次数（buckets数）。
HashSet不是线程安全的，如果有多个线程同时访问，并且至少一个线程在做修改，应该要对线程进行同步或者通过Collections.synchronizedSet方法把它转为线程安全的集合，如：
 Set s = Collections.synchronizedSet(new HashSet(...));
如果有线程创建了HashSet的遍历迭代器Interator，那么其他线程对HashSet的修改会让Interator抛出ConcurrentModificationException。
jdk1.8后的HashSet提供了spliterator()方法来创建Spliterator，通过Spliterator的forEachRemaining()方法可以并行的遍历HashSet的元素，Spliterator后续会单独介绍。
LinkedHashSet简介：
LinkedHashSet是继承自HashSet的一个集合类，没添加或者覆盖什么方法，建议使用HashSet就可以了。
NavigableSet 简介：
NavigableSet是继承自SortSet的接口，主要是弥补Interator遍历器的单一，提供了边界搜索，如：方法lower, floor， ceiling, higher，lower时找出小于目标元素的最大元素;如果没有则返回Null,floor方法是返回小于或者等于目标元素的最大元素，如果不存在的返回Null;ceiling是返回最小的大于或者等于目标元素的元素，不存在则返回null：higher方法则是返回最小的大于目标元素的元素，不存在则返回null。
它还提供一些获取子集视图的方法，如descendingSet、subSet、headSet、tailSet；
descendingSet方法返回该集合中包含的元素的反向顺序视图，对返回的集合的操作会同步到源集合，反过来也一样。
subSet返回指定坐标区间的子集，对返回的集合的操作会同步到源集合，反过来也一样。
headSet返回的是小于或者等于目标元素的子集，对返回的集合的操作会同步到源集合，反过来也一样。
tailSet返回时大于或者等于目标元素的子集，对返回的集合的操作会同步到源集合，反过来也一样。
线程安全的子类:
ConcurrentSkipListSet、CopyOnWriteArraySet
ConcurrentSkipListSet简介：
ConcurrentSkipListSet是实现了NavigableSet接口和继承自AbstractSet的Set集合类，它是线程安全的，内部存储实际是存在ConcurrentNavigableMap中。内部元素的存储是有序的，根据创建ConcurrentSkipListSet时提供的Comparator。
对它的操作如 contains, add, remove 平均时间是log，升序视图及其迭代器比降序视图要快。
它的容量变更的操作方法如：addAll、removeAll、retainAll、containsAll、containsAll、toArray并不能保证原子性，如在使用Interator遍历集合时，另一个线程进行addAll操作，那么iterator操作可能只能看到部分新添加的元素。
jdk1.8后支持Spliterator迭代器。
CopyOnWriteArraySet简介：
CopyOnWriteArraySet底层实现是CopyOnWriteArrayList,线程安全的，大部分操作和原理是同CopyOnWriteArrayList,包括创建遍历迭代器用的也是CopyOnWrietArrayList的，每次创建的迭代器获取的数据都是一个快照，不需要进行同步，其他线程对数据的修改不影响已经创建的Interator，它最适合于具有以下特征的应用程序：set 大小通常保持很小，只读操作远多于可变操作，需要在遍历期间防止线程间的冲突。  
因为通常需要复制整个基础数组，所以可变操作（add、set 和 remove 等等）的开销很大。
jdk1.8后支持Spliterator迭代器。

map
线程不安全的子类：
HashMap, TreeMap,LinkedHashMap
HashMap简介：
HashMap是线程不安全的提供所有Map操作的集合容器，支持Null为key或者value，并且是无序的。因为HashMap不是线程安全的，所以如果有个线程访问该级赫尔，并且至少一个线程在修改的话，应该进行修改操作的同步，或者使用Collections.synchronizedMap把它转成线程的安全的Map。
需要特别介绍下jdk1.8后HashMap的存储结构，因为和1.7之前都不太一样，性能也不一样。
jdk1.8之前，hashMap的存储结构是数组+链表，也就是发生hash冲突后的元素后插入到链表里，而不是存储在数组，这样的的话如果对于hash冲突比较严重的数据时，hashMap的查询速度就不是o(1)了，而是o('n');
所以，jdk1.8后，HashMap的存储结构是数组+链表or平衡树，因为平衡树的时间复杂度是o(log('n'))，是1.8后HashMap的查询复杂度是O(1)~O(log('n' ))。
初始化HashMap最重要的也是最影响性能的参数是:loadFactor、initialCapacity、TREEIFY_THRESHOLD（不可变）、UNTREEIFY_THRESHOLD(不可变)。
loadFactor是触发HashMap扩容的负载因子，默认是0.75，扩容是非常耗时的事情，所以这个负载因子很重要，0.75是性能比较好的一个数；initialCapacity是初始HashMap容量，因为HashMap迭代器Interator遍历时是会遍历整个存储数组和链表或者平衡树，所以initialCapacity也不应设太大。TREEIFY_THRESHOLD是触发链表转化成平衡树的阈值（同一个数组位置发生哈希碰撞而产生链表的数量），默认是8；UNTREEIFY_THRESHOLD是扩容后，原先发送哈希冲突的地方会减少，所以该值是发送扩容后平衡树转链表的哈希冲突数量阈值，默认是6。
TreeMap简介：
TreeMap是一个基于红黑树存储结构的实现了NavigableMap和继承自AbstractMap的有序Map集合。它存储元素的排序依赖于键的自然排序，或者根据创建映射时提供的 Comparator 进行排序，具体取决于使用的构造方法。TreeMap的基本操作 containsKey、get、put 和 remove 的时间复杂度是 log 。它不是线程安全的，如果多个线程同时访问该集合，并且至少一个线程在做修改操作的话， 应该要进行操作的同步处理，或者通过Collections.synchronizedSortedMap把它转为线程安全的Map，如：
SortedMap m = Collections.synchronizedSortedMap(new TreeMap(...));
TreeMap的interator方法返回创建遍历集合的支持fail-fast行为的Interator，但是如果在创建了Interator后，有其他线程修改了集合，那么Interator可能会抛出ConcurrentModificationException。
需要特别注意的是，不仅Put方法会改变集合的值，Map.Entry的setValue也是可以修改集合的值，如:
Set<Entry<String, Integer>> set = map.entrySet();
        for(Entry<String, Integer> entry:set){
            entry.setValue(3333);
        }
 
jdk1.8后支持KeySpliterator。
LinkedHashMap简介：
LinkedHashMap是继承自HashMap的有序集合，根据初始化参数accessOrder是false还是true来选择是按插入元素时的循序还是按访问循序进行排序。LinkedHashMap存储结构和HashMap是一样的，最大的不同是，存储节点Entry新增了双向连接，用于指向前一个节点和后一个节点，所以LinkedHashMap同时维持着一个双向链表，遍历元素时可以按链接循序遍历整个集合。其他特性和HashMap差不多。
线程安全的Map:
ConcurrentHashMap、HashTable、ConcurrentSkipListMap
ConcurrentHashMap简介：
ConcurrentHashMap是线程安全的HashMap，实现了ConcurrentMap接口，所以提供了一些原子性和线程安全的集合操作接口，如:
putIfAbsent(K, V)、replace(K, V, V)、compute(K, BiFunction<? super K, ? super V, ? extends V>)等。
JDK1.8之后的ConcurrentHashMap的实现和1.7之前已经大不一样了，当然存储结构还是和HashMap一样，数组+链表or红黑数,但是保证线程安全的机制从原来的给每个数组segment加锁方式变成了无锁的cas操作，特别是扩容方式被重写了，实现了无锁情况下多线程参与复制旧存储元素到新存储集合上。有一个最重要的不同点就是ConcurrentHashMap不允许key或value为null值。
我们拿最常用的put的方法来说明，如何实现无锁操作：
根据hash值计算这个新插入的点在table中的位置i，如果i位置是空的，直接放进去，否则进行判断，如果i位置是树节点，按照树的方式插入新的节点，否则把i插入到链表的末尾。ConcurrentHashMap中依然沿用这个思想，有一个最重要的不同点就是ConcurrentHashMap不允许key或value为null值。另外由于涉及到多线程，put方法就要复杂一点。在多线程中可能有以下两个情况
1.
如果一个或多个线程正在对ConcurrentHashMap进行扩容操作，当前线程也要进入扩容的操作中。这个扩容的操作之所以能被检测到，是因为transfer方法中在空结点上插入forward节点，如果检测到需要插入的位置被forward节点占有，就帮助进行扩容；
2.
3.
如果检测到要插入的节点是非空且不是forward节点，就对这个节点加锁，这样就保证了线程安全。尽管这个有一些影响效率，但是还是会比hashTable的synchronized要好得多。
4.
整体流程就是首先定义不允许key或value为null的情况放入  对于每一个放入的值，首先利用spread方法对key的hashcode进行一次hash计算，由此来确定这个值在table中的位置。
如果这个位置是空的，那么直接放入，而且不需要加锁操作。
    如果这个位置存在结点，说明发生了hash碰撞，首先判断这个节点的类型。如果是链表节点（fh>0）,则得到的结点就是hash值相同的节点组成的链表的头节点。需要依次向后遍历确定这个新加入的值所在位置。如果遇到hash值与key值都与新加入节点是一致的情况，则只需要更新value值即可。否则依次向后遍历，直到链表尾插入这个结点。  如果加入这个节点以后链表长度大于8，就把这个链表转换成红黑树。如果这个节点的类型已经是树节点的话，直接调用树节点的插入方法进行插入新的值。
因为为了要实现无锁，ConcurrentHashMap新增了许多私有方法和属性，推荐一篇写得很详细的博客:
http://blog.csdn.net/u010723709/article/details/48007881
jdk1.8后支持等流式处理操作包括forEach、map和reduce操作。
HashTable简介：
HashTable是线程安全的HashMap,其实就在修改方法上添加synchronized关键字进行同步，同步的粒度太大，性能不佳，不建议使用。
ConcurrentSkipListMap简介:
ConcurrentSkipListMap是基于SkipList存储结构实现的线程安全的有序Map集合，不支持Null为value或者为key，我们都知道，线程安全的集Map可以用ConcurrentHashMap，有序的Map可以用TreeMap，但是线程安全且有序的目前ConcurrentSkipListMap。
ConcurrentSkipListMap实现了ConcurrentNavigableMap接口，所以提供了一些导航方法，如查询小于目标key的最大entry、大于目标Key的最小entry、最开始的entry,最末，它的查询的最好时间复杂度平均为O(log n)，最差是O，主要是用空间换时间，节点上冗余了其他节点的引用并且低曾包含上一层所有节点信息，来实现快速查找，可以看下面的SkipList结构介绍。
SkipList是类似于LinedList的链表，但是不同的是LinkedList存储的是前后节点的引用，访问的时候是依次访问，而SkipList是存的是跨越多个点的引用，如下图：低一层包含比上一层更多的节点，上一层的节点跨度比较大，SkipList里层信息有Index维护，Index包含下一级index的引用，同一层数据节点的头节点的引用，数据存储由Node节点维护，每个Node节点维护右边比自己Key大的节点的引用，以及下一层自己的引用。
在查询的时候，比如下图查询key为45的节点，先从Inded3查询第一层，发现45大于3小于62,于是查询到下一层，发现45大于3、大于23小于62，于是从23节点往下走，发现23下一级就是45,查询结束。总共走了5步，这个是效果比较差的情况，和链表查询次数一样。
如果查询的节点是62，那么只需要走两步就找到结果，如果是链表的话需要7步，所以比链表快上不少。每个节点存储多少个节点的引用是随机产生的，而这也是影响SkipList查询效率的主要因素之一。
SkipList层数合适时自顶向下搜索，理想情况下每下降一层，搜索范围减小一半，达到类似二分查找的效果，效率为O(lgn)；最坏情况下也只是curr从head移动到tail，效率为O。

 
现在来说说ConcurrentSkipListMap如何在无锁情况下实现并发：
核心思想就是通过cas操作来代替锁，如果要执行的操作与预期不一样，就重新执行刚才的动作，直到成功为止。如下doPut部分代码所示
for (;;) {
        // 找到key的前继节点
        Node<K,V> b = findPredecessor(key);
        // 设置n为“key的前继节点的后继节点”，即n应该是“插入节点”的“后继节点”
        Node<K,V> n = b.next;
        for (;;) {
            if (n != null) {
                Node<K,V> f = n.next;
                // 如果两次获得的b.next不是相同的Node，就跳转到”外层for循环“，重新获得b和n后再遍历。
                if (n != b.next)
                    break;
            。。。。
jdk1.8后支持KeySpliterator。

 
queue
线程不安全的子类
ArrayDeque、 PriorityQueue
ArrayDeque简介：
ArrayDeque是一个实现了Deque接口的双端队列,是一种具有队列和栈的性质的数据结构。双端队列中的元素可以从两端弹出，其限定插入和删除操作在表的两端进行。不支持Null元素，不是线程安全的，把它当栈时,也就是只允许从一端插入数据和获取，比Stack快；把它当队列时它即从一端插入，从另一端获取数据，比LinkedList要快。大多数操作都是在平均的常数时间内运行的，除了如remove 、removeFirstOccurrence 、  removeLastOccurrence、contains、 iterator.remove()这些是在线性的时间内完成即数数据增加而线性增加。
ArrayDeque的iterator是支持fast-fail的，也就是如果创建了遍历迭代器Interator，那么在此期间其他线程修改了ArrayDeque，那么Interator很大可能会抛出ConcurrentModificationException。
ArrayDeque是大小自增长的队列，内部使用数组存储数据、内部数组长度每次扩容都是翻倍的增长，为8、16、32….. 2的n次方，头指针head从内部数组的末尾开始，尾指针tail从0开始，在头部插入数据时，head减一，在尾部插入数据时，tail加一。当head==tail时说明数组的容量满足不了当前的情况，此时需要扩大容量为原来的二倍。
另外，从jdk1.8后，新增了Spliterator迭代器，支持并行遍历数据。
PriorityQueue简介：
PriorityQueue是实现了AbstractQueue接口的优先队列，它不是线程安全的，也就是每次取出的元素都是队列中key最小的，元素大小的评判可以通过元素本身的自然顺序（natural ordering），也可以通过构造时传入的比较器Comparator。不允许放入null元素；其通过堆实现，具体说是通过完全二叉树（complete binary tree）实现的小顶堆（任意一个非叶子节点的权值，都不大于其左右子节点的权值），PriorityQueue的底层实现是通过数组来构建小项堆。如下图所示:

jdk.18后支持Spliterator。
线程安全的子类
LinkedBlockingDeque、LinkedBlockingQueue、PriorityBlockingQueue、ArrayBlockingQueue、ConcurrentLinkedDeque、ConcurrentLinkedQueue
LinedBlockingDeque简介：
LinkedBlockingDeque是双向链表实现的双向并发阻塞队列，线程安全，该阻塞队列同时支持FIFO和FILO两种操作方式，即可以从队列的头和尾同时操作(插入/删除)；并且，该阻塞队列是支持线程安全。
此外，LinkedBlockingDeque还是可选容量的(防止过度膨胀)，即可以指定队列的容量。如果不指定，默认容量大小等于Integer.MAX_VALUE。
它的线程安全主要通过每个操作方法的内需要通过重入锁ReentrantLock进行同步，如下图代码，所有的方法需要获取这个主锁才能执行，从而保证了只有一个线程能进入修改LinkedBlockingDeque的方法，同时有两个条件Condition,一个是notEmpty，一个是notFull，当有元素新增进LinkedBlockingDeque时，notEmpty激活在notEmpty上等待线程，当新增元素时队列满了，需要在notFull上等待直到有线程消费元素后激活notFull。
新增元素的代码如下:
  public void putLast(E e) throws InterruptedException {
        if (e == null) throw new NullPointerException();
        Node<E> node = new Node<E>(e);
        final ReentrantLock lock = this.lock;
        lock.lock();
try {
            while (!linkLast(node))
  notFull.await();
        } finally {
            lock.unlock();
        }
    }
 
LinkedBlockingQueue简介：
LinkedBlockingQueue是一个单向链表实现的阻塞队列，先进先出的顺序。支持多线程并发操作，线程安全，它是无界的队列，LinkedBlockingQueue继承AbstractQueue，实现了BlockingQueue，Serializable接口。内部使用单向链表存储数据，默认初始化容量是Integer最大值，消费时从头部获取元素，新增时从尾部新增。
插入和取出使用不同的锁，putLock插入锁，takeLock取出锁，添加和删除数据的时候可以并行。多CPU情况下可以同一时刻既消费又生产。
jdk1.8后也支持Spliterator。
PriorityBlockingQueue简介：
PriorityBlockingQueue是线程安全PriorityQueue，和PriorityQueue相比，主要是新增和消费元素方法需要获取一个ReentrantLock锁进行同步，从而保证了线程的安全，peek()是当队列无元素时，返回空，take()是当队列无元素时一直notEmpty这个条件上等待，直到有线程往队列新增元素时，才会从新把notEmpty条件激活，take()才从新往下执行。
特别注意的是PriorityBlockingQueue的序列化输出方法其实是把自己转成PriorityQueue然后在调PriorityQueue序列化输出方法。
1.8后支持Spliterator并行流式迭代器。
ArrayBlockingQueue简介：
ArrayBlockingQueue是数组实现的线程安全的有界的阻塞队列，先进先出(FIFO),初始化ArrayBlockingQueue时必须指定初始容量，并且初始化后容量大小不可变。它的线程安全的实现机制和PriorityBlockingQueue一样，每个操作方法需要先获取同一个ReentrantLock进行同步。
1.8后支持Spliterator并行流式迭代器。
ConcurrentLinkedDeque简介：
它是一个基于链表的无界的线程安全的非堵塞双端队列，不支持Null元素，对于新增、删除、查询都是线程安全的。但是它的size方法不是常数时间的，它需要每次遍历统计才能知道数据量的大小，并且有可能在遍历统计过程中有其他线程修改了元素导致统计不准确。
 像 addAll、removeAll, retainAll, containsAll,equals,  toArray 操作都不能保证原子性，有可能获取到的结果是中间结果。
它是非堵塞双端队列，也就是peek()获取第一个元素，如果队列为空，则返回null，而不是等待。
线程安全保证是通过CAS操作级多重检查机制（即每次设值前判断当前状态不是未被其他线程修改），比如在头部新增一个对象时，会进入一个无线循环体，然后读取头部节点，如果头节点的下一个节点是null，则表示这是一个空集合，然后设置用cas操作新节点newNode的next节点为head节点p，p节点设置通过cas设置pre节点为新节点newNode并且判断设置之前pre节点是Null，p节点pre不是Null则表示有其他线程在修改，则退回外循环从新获取头节点进行判断。如果设置成功，则判断p节点是不是头节点，如果不是，表示p是数据节点，则需要把newNode通过cas设置为头节点！具体代码如下：
private void linkFirst(E e) {
        checkNotNull(e);
        final Node<E> newNode = new Node<E>(e);
        restartFromHead:
for (;;)
    for (Node<E> h = head, p = h, q;;) {
        if ((q = p.prev) != null &&
                    (q = (p = q).prev) != null)
            //没一次循环都要检查头部更新
            // 如果h不等于head节点，则p =q,
                    p = (h != (h = head)) ? h : q;
        else if (p.next == p) //如果p的next节点等于自己，那么跳出循环，从新进入循环体
            continue restartFromHead;
                else {
            // p 是头节点
                    newNode.lazySetNext(p); // CAS 设置新节点NewNode的next节点是p
                    if (p.casPrev(null, newNode)) {
                if (p != h) // hop two nodes at a time
                            casHead(h, newNode);  //如果设置失败也是okay
                return; //设置成功返回
                    }
            
                }
            }
    }
jdk1.8后也提供Spliterator迭代器。
ConcurrentLinkedQueue简介：
它是一个线程安全的无界先进先出（FIFO）的队列,只能从头部取数据，尾部添加数据，并且不允许存储Null元素，它的迭代器Interator创建后，其他线程对队列的修改并不会抛出ConcurrentModificationException，并且还能弱一致的表示当前队列的状态，其他线程对队列的修改它也可以获取，这是因为它创建迭代器的和遍历元素用的是同一个方法，只是创建Interator时不返回元素，Next（）方法返回元素,也就是每遍历下一个元素时就相当于重新创建一个Interator，当时如果其他线程对队列的修改发生在一次迭代中间，那么本次迭代Next返回的极少可能是不准确的，但也仅次迭代而已，下一次会又准确了。
它的size方法需要遍历全部元素统计，所以比较费时间并且还不一定准确！
它的容量变更的操作方法如：addAll、removeAll、retainAll、containsAll、containsAll、toArray并不能保证原子性，如在使用Interator遍历集合时，另一个线程进行addAll操作，那么iterator操作可能只能看到部分新添加的元素。
它的线程安全策略和ConcurrentLinkedDeque一样，CAS操作和多重检查。
jdk1.8后也支持Spliterator。



Java语言提供了一种稍弱的同步机制，即volatile变量，用来确保将变量的更新操作通知到其他线程。当把变量声明为volatile类型后，编译器与运行时都会注意到这个变量是共享的，因此不会将该变量上的操作与其他内存操作一起重排序。volatile变量不会被缓存在寄存器或者对其他处理器不可见的地方，因此在读取volatile类型的变量时总会返回最新写入的值。
　　在访问volatile变量时不会执行加锁操作，因此也就不会使执行线程阻塞，因此volatile变量是一种比sychronized关键字更轻量级的同步机制。

.Java 中 sleep 方法和 wait 方法的区别？ 
虽然两者都是用来暂停当前运行的线程，但是sleep（）实际上只是短暂停顿，因为不会释放锁，而wait表示条件等待，需要释放锁，其他等待的线程才能在满足条件时获取到该锁。

.解释Java堆空间及GC？ 
当通过java命令启动java进程的时候，会为它分配内存。内存的一部分用于创建堆空间，当程序中创建对象的时候，就从堆空间中分配内存，GC是JVM内部的有一个进程，回收无效对象的内存用于将来的分配。
Java中堆和栈有什么区别？ 
JVM中堆和栈属于不同的内存区域，使用目的也不同，栈常用于保存方法帧和局部变量，而对象总是在堆中分配，栈比较小，不在多线程中共享，而堆被整个JVM的所有线程共享。
.Thread类中的start（）和run()方法有什么区别？ 
start（）方法被用来启动新创建的线程，而且，start（）内部调用了run（）方法，这和直接调用run（）方法的效果不一样，当你调用run（）方法的时候，只会是咋线程中调用，没有新的线程启动，start()方法才会启动新线程。

序列化与反序列化
序列化：把Java对象转换为字节序列的过程。 
　　 
反序列化：把字节序列恢复为Java对象的过程。
Java对象是在JVM中生成的，如果需要远程传输或保存到硬盘上，就需要将Java对象转换成可传输的文件流。
三种方式
1.利用Java的序列化功能序列成字节（字节流）也就是接下来要讲的。一般是需要加密传输时才用。
2.将对象包装成JSON字符串（字符流）
3.protoBuf工具(二进制)

实现
实现了如下两个接口之一的类的对象才能被序列化： 
　　 
　　1） Serializable 
　　 
　　2） Externalizable
　　序列化：ObjectOutputStream代表对象输出流，它的writeObject(Object obj)方法可对参数指定的obj对象进行序列化，把得到的字节序列写到一个目标输出流中。
　　反序化：ObjectInputStream代表对象输入流，它的readObject()方法从一个源输入流中读取字节序列，再把它们反序列化为一个对象，并将其返回。
注：使用writeObject() 和readObject()方法的对象必须已经被序列化
四、serialVersionUID
如果serialVersionUID没有显式生成，系统就会自动生成一个。此时，如果在序列化后我们将该类作添加或减少一个字段等的操作，系统在反序列化时会重新生成一个serialVersionUID然后去和已经序列化的对象进行比较，就会报序列号版本不一致的错误。为了避免这种问题， 一般系统都会要求实现serialiable接口的类显式的生明一个serialVersionUID。
所以显式定义serialVersionUID有如下两种用途：
　　　1、 希望类的不同版本对序列化兼容时，需要确保类的不同版本具有相同的serialVersionUID；
　　　2、 不希望类的不同版本对序列化兼容时，需要确保类的不同版本具有不同的serialVersionUID。
五、序列化机制算法
　　1. 所有保存到磁盘中的对象都有一个序列化编号
　　2. 当程序试图序列化一个对象时，程序先检查该对象是否已经被序列化过。如果从未被序列化过，系统就会将该对象转换成字节序列并输出；如果已经序列化过，将直接输出一个序列化编号。

通过tansient阻止实例变量的序列化。
Java默认会序列化所有的实例变量，如果我们不想序列化某一个实例变量，就可以使用tansient这个关键字修饰。

单例模式的序列化



Java面试题库及答案解析
1、面向对象编程（OOP）有哪些优点？
代码开发模块化，更易维护和修改。
代码复用。
增强代码的可靠性和灵活性。
增加代码的可理解性。
2、面向对象编程有哪些特性？
封装、继承、多态、抽象
封装
封装给对象提供了隐藏内部特性和行为的能力。对象提供一些能被其他对象访问的方法来改变它内部的数据。在Java当中，有3种修饰符：public，private和protected。每一种修饰符给其他的位于同一个包或者不同包下的对象赋予了不同的访问权限。
下面列出了使用封装的好处：
通过隐藏对象的属性来保护对象内部的状态。
提高了代码的可用性和可维护性，因为对象的行为可以被单独的改变或者是扩展。
禁止对象之间的不良交互提高模块化。
继承
继承给对象提供了从基类获取字段和方法的能力。继承提供了代码的重用，也可以在不修改类的情况下给现存的类添加新特性。
多态
多态是编程语言给不同的底层数据类型做相同的接口展示的一种能力。一个多态类型上的操作可以应用到其他类型的值上面。
抽象
抽象是把想法从具体的实例中分离出来的步骤，因此，要根据他们的功能而不是实现细节来创建类。Java支持创建只暴露接口而不包含方法实现的抽象的类。这种抽象技术的主要目的是把类的行为和实现细节分离开。
3、什么是Java虚拟机？为什么Java被称作是“平台无关的编程语言”？
Java虚拟机是一个可以执行Java字节码的虚拟机进程。Java源文件被编译成能被Java虚拟机执行的字节码文件。
Java被设计成允许应用程序可以运行在任意的平台，而不需要程序员为每一个平台单独重写或者是重新编译。Java虚拟机让这个变为可能，因为它知道底层硬件平台的指令长度和其他特性。
4、JDK和JRE的区别是什么？
JRE(Java运行时环境) 是将要执行Java程序的Java虚拟机。它同时也包含了执行applet需要的浏览器插件。JDK(Java开发工具包) 是完整的Java软件开发包，包含了JRE，编译器和其他的工具(比如：JavaDoc，Java调试器)，可以让开发者 开发、编译、执行Java应用程序。
5、”static”关键字是什么意思？Java中是否可以覆盖(override) 一个private或者是static的方法？
“static”关键字表明一个成员变量或者是成员方法可以在没有所属的类的实例的情况下被访问。
Java中static方法不能被覆盖，因为方法覆盖是基于运行时动态绑定的，而static方法是编译时静态绑定的。static方法跟类的任何实例都不相关，所以概念上不适用。
6、是否可以在static环境中访问非static变量？
不可以。static变量在Java中是属于类的，它在所有的实例中的值是一样的。当类被Java虚拟机载入的时候，会对static变量进行初始化。如果你的代码尝试不用实例来访问非static的变量，编译器会报错，因为这些变量还没有被创建出来，还没有跟任何实例关联上。
7、Java支持的数据类型有哪些？什么是自动拆装箱？
Java支持的基本数据类型有：
byte
short
int
long
float
double
boolean
char
自动装箱是Java编译器在基本数据类型和对应的对象包装类型之间做的一个转化。比如：把int转化成Integer。反之就是自动拆箱。
8、Java中的方法覆盖(Overriding)和方法重载(Overloading)是什么意思？
方法覆盖是说子类重新实现父类的方法。方法覆盖必须有相同的方法名，参数列表和返回类型。
方法重载发生在同一个类里面，两个或者是多个方法的方法名相同但是参数列表不同。
9、Java中，什么是构造函数？什么是构造函数重载？什么是复制构造函数？
当新对象被创建的时候，构造函数会被调用。每一个类都有构造函数。在程序员没有给类提供构造函数的情况下，Java编译器会为这个类创建一个默认的构造函数。
Java中构造函数重载和方法重载很相似。可以为一个类创建多个构造函数。每一个构造函数必须有它自己唯一的参数列表。
Java不支持像C++那样的复制构造函数，这个不同点是因为如果你不自己写构造函数的情况下，Java不会创建默认的复制构造函数。
10、Java支持多继承么？
不支持，Java不支持多继承。每个类都只能继承一个类，但是可以实现多个接口。
11、抽象类和接口的区别是什么？
Java支持创建抽象类和接口。它们的区别在于：

接口中所有的方法隐含的都是抽象的。而抽象类则可以同时包含抽象和非抽象的方法。


类可以实现很多个接口，但是只能继承一个抽象类


类如果要实现一个接口，它必须要实现接口声明的所有方法。但是，类可以不实现抽象类声明的所有方法，在这种情况下，类也必须得声明成是抽象的。


抽象类在实现接口时，可以不实现接口里面的方法。


Java接口中声明的变量默认都是final的。抽象类可以包含非final的变量。


Java接口中的成员方法默认是public的。抽象类的成员方法可以是private，protected或者是public。


接口是绝对抽象的，不可以被实例化。抽象类也不可以被实例化，但是，如果它包含main方法的话是可以被调用的。

12、什么是值传递？什么是引用传递？
对象被值传递，意味着传递了对象的一个副本。因此，就算是改变了对象副本，也不会影响源对象的值。
对象被引用传递，意味着传递的并不是实际的对象，而是对象的引用。因此，外部对引用对象所做的改变会反映到所有的对象上。
13、进程和线程的区别是什么？
进程是执行着的应用程序，而线程是进程内部的一个执行序列。一个进程可以有多个线程。
14、创建线程有几种不同的方式？你喜欢哪一种？为什么？
创建线程有以下几种方式：

继承Thread类


实现Runnable接口


应用程序可以使用Executor框架来创建线程池

实现Runnable接口这种方式更受欢迎，因为这不需要继承Thread类。在已经继承了别的类的情况下，这需要多继承（而Java不支持多继承），只能实现接口。同时，线程池也是非常高效的，很容易实现和使用。
15、解释一下线程的几种可用状态
线程可以处于以下几种状态：

就绪(Runnable)：线程准备运行，不一定立马就能开始执行。


运行中(Running)：程序正在执行线程的代码。


等待中(Waiting)：线程处于阻塞的状态，等待外部的处理结束。


睡眠中(Sleeping)：线程被强制睡眠。


I/O阻塞(Blocked on I/O)：等待I/O操作完成。


同步阻塞(Blocked on Synchronization)：等待获取锁。


死亡(Dead)：线程完成了执行。

16、同步方法和同步代码块的区别是什么？
同步方法就是在方法前加关键字synchronized，然后被同步的方法一次只能有一个线程进入，其他线程等待。
而同步代码块则是在方法内部使用大括号使得一个代码块得到同步。同步块会有一个锁定的“对象”。同步代码块的同步范围更加准确。
17、在监视器(Monitor)内部，是如何做线程同步的？程序应该做哪种级别的同步？
监视器和锁在Java虚拟机中是一起使用的。监视器监视同步代码块，确保一次只有一个线程执行同步代码块。每一个监视器都和一个对象引用相关联。线程在获取锁之前不允许执行同步代码。
18、什么是死锁(deadlock)？
两个线程都在等待对方执行完毕才能继续往下执行的时候就发生了死锁。结果就是两个线程都陷入了无限的等待中。
19、如何确保N个线程可以访问N个资源同时又不导致死锁？
使用多线程的时候，一种非常简单的避免死锁的方式就是：指定获取锁的顺序，并强制线程按照指定的顺序获取锁。因此，如果所有的线程都是以同样的顺序加锁和释放锁，就不会出现死锁了。
20、Java集合类框架的基本接口有哪些？
Java集合类里面最基本的接口有：

Collection：代表一组对象，每一个对象都是它的子元素。


Set：不包含重复元素的Collection。


List：有顺序的Collection，并且可以包含重复元素。


Map：可以把键(key)映射到值(value)的对象，键不能重复。

21、为什么集合类没有实现Cloneable和Serializable接口？
克隆(cloning)或者是序列化(serialization)的语义和含义是跟具体的实现相关的。因此，应该由集合类的具体实现来决定如何被克隆或者是序列化。
22、什么是迭代器(Iterator)？
Iterator接口提供了很多对集合元素进行迭代的方法。每一个集合类都包含了可以返回迭代器实例的迭代方法。迭代器可以在迭代的过程中删除底层集合的元素。
23、Iterator和ListIterator的区别是什么？
他们的区别如下：

Iterator可用来遍历Set和List集合，但是ListIterator只能用来遍历List。


Iterator对集合只能是前向遍历，ListIterator既可以前向也可以后向。


ListIterator实现了Iterator接口，并包含其他的功能，比如：增加元素，替换元素，获取前一个和后一个元素的索引，等等。

24、快速失败(fail-fast)和安全失败(fail-safe)的区别是什么？
Iterator的安全失败是基于对底层集合做拷贝，因此，它不受源集合上修改的影响。java.util包下面的所有的集合类都是快速失败的，而java.util.concurrent包下面的所有的类都是安全失败的。快速失败的迭代器会抛出ConcurrentModificationException异常，而安全失败的迭代器永远不会抛出这样的异常。
25、Java中的HashMap的工作原理是什么？
Java中的HashMap是以键值对(key-value)的形式存储元素的。HashMap需要一个hash函数，它使用hashCode()和equals()方法来向集合添加元素和从集合检索元素。当调用put()方法的时候，HashMap会计算key的hash值，然后把键值对存储在集合中合适的索引上。如果key已经存在了，value会被更新成新值。
26、hashCode()和equals()方法的重要性体现在什么地方？
Java中的HashMap使用hashCode()和equals()方法来确定键值对的索引，当根据键获取值的时候也会用到这两个方法。如果没有正确的实现这两个方法，两个不同的键可能会有相同的hash值，因此，可能会被集合认为是相等的。而且，这两个方法也用来发现重复元素。所以这两个方法的实现对HashMap的精确性和正确性是至关重要的。
27、HashMap和Hashtable有什么区别？
HashMap和Hashtable都实现了Map接口，他们有以下不同点：

HashMap允许键和值是null，而Hashtable不允许键或者值是null。


Hashtable是同步的，而HashMap不是。因此，HashMap更适合于单线程环境，而Hashtable适合于多线程环境。


HashMap提供了可供应用迭代的键的集合，因此，HashMap是快速失败的。另一方面，Hashtable提供了对键的列举(Enumeration)。

28、数组(Array)和列表(ArrayList)有什么区别？什么时候应该使用Array而不是ArrayList？
Array 和ArrayList 有以下的不同点：

Array可以包含基本类型和对象类型，ArrayList只能包含对象类型。


Array大小是固定的，ArrayList的大小是动态变化的。


ArrayList提供了更多的方法和特性，比如：addAll()，removeAll()，iterator()等等。

对于基本类型数据，ArrayList 使用自动装箱来减少编码工作量。但是，当处理固定大小的基本数据类型的时候，这种方式相对比较慢，这时候应该使用Array。
29、ArrayList和LinkedList有什么区别？
ArrayList和LinkedList 有以下的不同点：

ArrayList是基于索引的数据接口，它的底层是数组。它可以以O(1)时间复杂度对元素进行随机访问。而 LinkedList是以链表的形式存储它的数据，每一个元素都和它的前一个和后一个元素链接在一起，在这种情况下，查找某个元素的时间复杂度是O(n)。


相对于ArrayList，LinkedList的插入、添加、删除操作速度更快，因为当元素被添加到集合任意位置的时候，不需要像数组那样重新计算大小或者是更新索引。


LinkedList比ArrayList更占内存，因为LinkedList为每一个节点存储了两个引用，一个指向前一个元素，一个指向下一个元素。

30、Comparable和Comparator接口是干什么的？列出它们的区别。
Java提供了只包含一个compareTo()方法的Comparable接口。这个方法可以个给两个对象排序。具体来说，它返回负数，0，正数来表明输入对象小于，等于，大于已经存在的对象。
Java提供了包含compare()和equals()两个方法的Comparator接口。compare()方法用来给两个输入参数排序，返回负数，0，正数表明第一个参数是小于，等于，大于第二个参数。equals()方法需要一个对象作为参数，它用来决定输入参数是否和Comparator相等。只有当输入参数也是一个Comparator并且输入参数和当前Comparator的排序结果是相同的时候，这个方法才返回true。
31、什么是Java优先级队列(Priority Queue)？
PriorityQueue是一个基于优先级堆的无界队列，它的元素是按照自然顺序(natural order)排序的。在创建的时候，我们可以给它提供一个负责给元素排序的比较器。PriorityQueue不允许null值，因为他们没有自然顺序，或者说他们没有任何的相关联的比较器。最后，PriorityQueue不是线程安全的，入队和出队的时间复杂度是O(log(n))。
32、你了解大O符号(big-O notation)么？你能给出不同数据结构的例子么？
大O符号描述了当数据结构里面的元素增加的时候，算法的规模或者是性能在最坏的场景下有多么好。
大O符号也可用来描述其他的行为，比如：内存消耗。因为集合类实际上是数据结构，我们一般使用大O符号基于时间，内存和性能来选择最好的实现。大O符号可以对大量数据的性能给出一个很好的说明。
33、如何权衡是使用无序的数组还是有序的数组？
有序数组最大的好处在于查找的时间复杂度是O(log n)，而无序数组是O(n)。有序数组的缺点是插入操作的时间复杂度是O(n)，因为值大的元素需要往后移动来给新元素腾位置。相反，无序数组的插入时间复杂度是常量O(1)。
34、Java集合类框架的最佳实践有哪些？
根据应用的需要正确选择要使用的集合的类型对性能非常重要，比如：元素的大小是固定的，而且能事先知道，我们就应该用Array而不是ArrayList。
有些集合类允许指定初始容量。因此，如果我们能估计出存储的元素的数目，我们可以设置初始容量来避免重新计算hash值或者是扩容。
为了类型安全，可读性和健壮性的原因总是要使用泛型。同时，使用泛型还可以避免运行时的ClassCastException。
使用JDK提供的不变类(immutable class)作为Map的键可以避免为我们自己的类实现hashCode()和equals()方法。
编程的时候接口优于实现。
底层的集合实际上是空的情况下，返回长度是0的集合或者是数组，不要返回null。
35、Enumeration接口和Iterator接口的区别有哪些？
Enumeration速度是Iterator的2倍，同时占用更少的内存。但是，Iterator远远比Enumeration安全，因为其他线程不能够修改正在被iterator遍历的集合里面的对象。同时，Iterator允许调用者删除底层集合里面的元素，这对Enumeration来说是不可能的。
36、HashSet和TreeSet有什么区别？
HashSet是由一个hash表来实现的，因此，它的元素是无序的。add()，remove()，contains()方法的时间复杂度是O(1)。
TreeSet是由一个树形的结构来实现的，它里面的元素是有序的。因此，add()，remove()，contains()方法的时间复杂度是O(logn)。
37、Java中垃圾回收（GC）有什么目的？什么时候进行垃圾回收？
垃圾回收（GC）的目的是识别并且丢弃应用不再使用的对象来释放和重用资源。
38、System.gc()和Runtime.gc()会做什么事情？
这两个方法用来提示JVM要进行垃圾回收。但是，立即开始还是延迟进行垃圾回收是取决于JVM的。
39、finalize()方法什么时候被调用？析构函数(finalization)的目的是什么？
在释放对象占用的内存之前，垃圾收集器会调用对象的finalize()方法。一般建议在该方法中释放对象持有的资源。
40、如果对象的引用被置为null，垃圾收集器是否会立即释放对象占用的内存？
不会，在下一个垃圾回收周期中，这个对象将是可被回收的。
41、Java堆的结构是什么样子的？什么是堆中的永久代(Perm Gen space)?
JVM的堆是运行时数据区，所有类的实例和数组都是在堆上分配内存。它在JVM启动的时候被创建。对象所占的堆内存是由自动内存管理系统也就是垃圾收集器回收。
堆内存是由存活和死亡的对象组成的。存活的对象是应用可以访问的，不会被垃圾回收。死亡的对象是应用不可访问尚且还没有被垃圾收集器回收掉的对象。一直到垃圾收集器把这些对象回收掉之前，他们会一直占据堆内存空间。
42、串行(serial)收集器和吞吐量(throughput)收集器的区别是什么？
吞吐量收集器使用并行版本的新生代垃圾收集器，它用于中等规模和大规模数据的应用程序。而串行收集器对大多数的小应用(在现代处理器上需要大概100M左右的内存)就足够了。
43、在Java中，对象什么时候可以被垃圾回收？
当对象对当前使用这个对象的应用程序变得不可触及的时候，这个对象就可以被回收了。
44、JVM的永久代中会发生垃圾回收么？
垃圾回收不会发生在永久代，如果永久代满了或者是超过了临界值，会触发完全垃圾回收(Full GC)。如果你仔细查看垃圾收集器的输出信息，就会发现永久代也是被回收的。这就是为什么正确的永久代大小对避免Full GC是非常重要的原因。
45、Java中的两种异常类型是什么？他们有什么区别？
Java中有两种异常：受检查的(checked)异常和不受检查的(unchecked)异常。不受检查的异常不需要在方法或者是构造函数上声明，就算方法或者是构造函数的执行可能会抛出这样的异常。而且不受检查的异常可以传播到方法或者是构造函数的外面。相反，受检查的异常必须要用throws语句在方法或者是构造函数上声明。
46、Java中Exception和Error有什么区别？
Exception和Error都是Throwable的子类。Exception用于用户程序可以捕获的异常情况。Error定义了不期望被用户程序捕获的异常。

47、Java 为什么是高效的 ( High Performance )？
因为 Java 使用 Just-In-Time (即时) 编译器。
把Java字节码转换成可以直接发送给处理器的指令。
48、列举出2个 IDE
Eclipse
IntelliJ IDEA
49、面向对象的特征有哪些？

封装


继承


多态


抽象

50、JDK JRE JVM？
JDK
Java Development Kit 用作开发, 包含了JRE，编译器和其他的工具(比如: JavaDoc，Java调试器)，可以让开发者开发、编译、执行Java应用程序。
JRE
Java 运行时环境，是将要执行 Java 程序的 Java 虚拟机，可以想象成它是一个容器，JVM 是它的内容。
JRE = JVM + Java Packages Classes(like util, math, lang, awt, swing etc) + runtime libraries.
JVM
Java virtual machine (Java 虚拟机) 是一个可以执行 Java 编译产生的 Java class 文件 (bytecode) 的虚拟机进程，是一个纯的运行环境。
51、什么是对象 (Object)？
对象是程序运行时的实体
它的状态存储在 fields (也就是变量)
行为是通过方法 (method) 实现的
方法上操作对象的内部的状态
方法是对象对对象的通信的主要手段
52、一个类是由哪些变量构成的？

本地变量：在方法体，构造体内部定义的变量，在方法结束的时候就被摧毁


实例变量：在类里但是不在方法里，在类被载入的时候被实例化


类变量：在类里但是不在方法里，加了 static 关键字，也可以叫做静态变量

53、静态变量和实例变量的区别？

在语法定义上的区别：静态变量前要加static关键字，而实例变量前则不加。


在程序运行时的区别：


实例变量属于某个对象的属性，必须创建了实例对象，才能使用这个实例变量。


静态变量不属于某个实例对象，而是属于类，所以也称为类变量，只要程序加载了类的字节码，不用创建任何实例对象，静态变量就可以被使用了。


总之，实例变量必须创建对象后才可以通过这个对象来使用，静态变量则可以直接使用类名来使用。

