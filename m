From: "=?GB2312?Q?=C1=F5=B2=CA=C6=BB?=" <lcpcaiping@sohu.com>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: ramdisk problem
Mime-Version: 1.0
Content-Type: text/plain
Date: Mon, 5 Apr 2004 21:53:24 +0800
Message-Id: <20040405135322.5248D87AA2@smtp02.sohu.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,hello:
 I use montavista linux,and I use ramdisk root filesystem.But when I run
a simple program (helloworld),I made an error as fellow. I can run the
helloworld program successfully in nfs . Any idea? Thank you very much.

=>tftp 1000000 ramdisk

=>bootm ff850000 1000000

bash# ls
bin            etc            linuxrc        myapplication
dev            lib            lost+found
bash# cd myapplication
bash# ls
helloworld-8xx
bash# ./helloworld-8xx
/helloworld-8xx: error in loading shared libraries
: undefined symbol: __libc_start_main
bash#

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
