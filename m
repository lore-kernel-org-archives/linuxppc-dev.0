Message-ID: <38D3D7FB.8D9BDE6E@apus.co.at>
Date: Sat, 18 Mar 2000 20:24:44 +0100
From: "Reni Pachernegg" <rene.pachernegg@apus.co.at>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: unable to open driver
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I am writing a special serial console driver for our embedded linuxppc
system. The registration of the serial console driver works fine and I
get all the kernel messages via printk.

The registration of ttyS works fine too. But the open(/dev/console) in
main.c successfully doesnt work. I tried the open with ttyS and all the
other drivers I registered successfully too. I followed the open
instruction up to open_namei in namei.c where the return value is
ENOENT.

How comes that the pseudofiles of the drivers dont exist? Doesnt the
registration include the creation of these files? Do I have to create
them myself with do_mknod?
Any suggestions?

Thanks,
	Rene

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
