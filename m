From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AE9527E.15072@bjapp3>
Date: Fri, 27 Apr 2001 19:05:34 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: Can't execute /bin/sh /bin/init ?
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all,
	With maillist's help,i can run kernel in my borad.But when kernel mount
the NFS root files,then execute /sbin/init ,/usr/init etc,but when  kernel run
here,in minicom's term noting happen,i try to ping this borad,no answer.I use
hhl for linuxplanet ,and nfs file is in /opt/hardhat/devkit/ppc/8xx/target/.
my borad is use MPC850.kernel is for RPXlite.

main.c

......
        printk("%s\n",execute_command);
        if (execute_command)
                execve(execute_command,argv_init,envp_init);

        /*execve("/sbin/init",argv_init,envp_init);*/ ---------it can't not run term is noting--------
        execve("/etc/init",argv_init,envp_init);
        execve("/bin/init",argv_init,envp_init);
        execve("/bin/sh",argv_init,envp_init); -----it also can't  run ,term is noting------------
        panic("No init found.  Try passing init= option to kernel.");
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
