Message-ID: <EFB813091B18D511BD3600508B644F820A617EBE@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Protecting shared resources with preemptive  kernel
Date: Tue, 11 May 2004 18:55:59 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
My group has been working on a custom board based on MPC8540 and running
Linux kernel 2.4.20.
We've written some device drivers and came across an issue of protecting
shared resources within the kernel context that one day may have a
preemption turned on.
We tried to evaluate using spin-lock's for that purpose, but there're some
articles on the web that suggest it is not a safe solution when the kernel
preemption is turned on (potentially the kernel may hang).
I was just wondering if anybody has any experience with protecting shared
resources within a kernel context (e.g. for device drivers) when the
preemption is enabled.
Any suggestions and ideas would be greatly appreciated.

Thanks,

Adam Zajac
Motorola Inc, Global Telecom Solutions Sector
5555 N Beach St, Mailstop 8E, Fort Worth, TX 76137-2794
Phone: (817) 245-7963


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
