From: zjuzhou@163.net
MIME-Version: 1.0
Message-Id: <3AEA3CE5.06115@bjapp3>
Date: Sat, 28 Apr 2001 11:45:41 +0800 (CST)
To: linuxppc-embedded@lists.linuxppc.org
Subject: After mount nfs root filesystem,can't execute /bin/sh.
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all:
	i use hhl2.2.14 kerlner for RPXLite borad,i have porting it to my borad.
But when i boot use nfs as root filesystem,it always can't run .I use /opt/hardhat/devkit/ppc/8xx/target/ as nfs exports,and this is created from cdk1.2 for Linuxplant(i think this files is same as RPXlite's).


in main.c

execev("/sbin/init",argv_init,envp_init) /***it run here ,system is halt**/
execev("/bin/sh",argv_init.envp_init) /***it also halt*******/


	Who can help me,thanks.
Dross Chou.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
