Message-ID: <000901c0b1fa$38134060$8021690a@huawei.com>
From: "machael" <dony.he@huawei.com.cn>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Strange problem after shell appears...
Date: Wed, 21 Mar 2001 19:29:40 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,all:

Now I can boot linux on my 8260-based custom board. But I have a strange
problem:

#############################
.....................
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 48k init
Sash shell (version 1.0)
sash# hel^@
###############################

After shell appears, I cannot run any built-in commands such as "ls" , "cp"
etc...
As you can see above, when  I type 2 or 3 characters(for example, "hel"),
then it appends "^@" automatically at once(So you see "hel^@" above). Then
it stops there. It has no any response  when I try to type any more
characters. But I can ping it from my host computer.
This means the target board is not crashed...

Of course I am sure the root NFS is OK. I have tried cross-compile sash
statically or dynamically, but both have the same result as above:

###########################################
    powerpc-linux-gcc -O2 -c -o sash.o sash.c
    powerpc-linux-gcc -O2 -c -o cmds.o cmds.c
    .....................
then:
    powerpc-linux-ld -O2 -static -s -o sash sash.o cmds.o ......
or
   powerpc-linux-ld  -O2 -Wl,--rpath,/lib -o sash sash.o cmds.o ...
################################################

Any ideas?
Thank you very much.

machael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
