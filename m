From: t.shantha.laxmi@exgate.tek.com
Message-ID: <21F9768AF088D211BF1C0008C71E578601686C92@ap-bang-m02.india.tek.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: init problems with 2.4.0 kernel
Date: Tue, 21 Nov 2000 01:52:13 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I am facing a problem in starting the "/sbin/init" process on my proprietary
board. The init process asks for a runlevel to be entered, even though "3"
is specified in the /etc/inittab. If I enter the runlevel as 3, it halts
saying "no more processes in this runlevel". The messages look something
like this:


Looking up port of RPC 100003/2 on 192.158.103.253
Looking up port of RPC 100005/2 on 192.158.103.253
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 40k init
INIT: version 2.77 booti

Enter runlevel: 3
INIT: Entering runlevel:
INIT: no more processes ft in this runlevel


It is a ppc board running linux kernel 2.4.0-test2-1.2.2-1. I have
downloaded the kernel from the mvista site. I am using CDK1.0(again got from
mvista) as the root filesystem. With my earlier version of the kernel
(2.2.13), I was not facing this problem.

Any help will be greatly appreciated,
- Shantha


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
