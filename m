Return-Path: <seema.pm@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id 78A67DE027
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 07:53:25 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so205371wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 14:53:24 -0700 (PDT)
Message-ID: <4e69a5150806261453n1196b5b8va61e330ea57bb00e@mail.gmail.com>
Date: Thu, 26 Jun 2008 14:53:24 -0700
From: "SEEMA pm" <seema.pm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: issue with kgdb on ppc
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8667_16878721.1214517204372"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_8667_16878721.1214517204372
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello

I'm trying to get kgdb working on a mpc8540 based target machine. I took the
latest patches which are for 2.6.13(mine is 2.6.11) and build and made
changes to config by enabling :
- Compile the kernel with debug info
- KGDB: kernel debugging with remote gdb
- KGDB: Console messages through gdb
- Method for KGDB communication (KGDB: On ethernet - in kernel)

I also added bootargs through uboot as:
kgdboe=6443@10.110.1.2/,6442@10.110.1.31/00:0F:1F:6E:F3:30 kgdbwait

Now, I'm getting the messages:
netconsole: not configured, aborting
kgdboe: eth0 doesn't support polling, aborting.
kgdboe: netpoll_setup failed kgdboe failed

And after some lines;

kgdb: Defering I/O setup to kernel module.
kgdb: Waiting for connection from remote gdb...
But then it goes to load ramdisk.

Can someone please provide some help on this

thanks

------=_Part_8667_16878721.1214517204372
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello<br><br>I&#39;m
trying to get kgdb working on a mpc8540 based target machine. I took
the latest patches which are for 2.6.13(mine is 2.6.11) and build and
made changes to config by enabling :<br>
- Compile the kernel with debug info<br>- KGDB: kernel debugging with remote gdb <br>- KGDB: Console messages through gdb<br>- Method for KGDB communication (KGDB: On ethernet - in kernel)<br><br>I also added bootargs through uboot as:<br>

kgdboe=<a href="http://6443@10.110.1.2/,6442@10.110.1.31/00:0F:1F:6E:F3:30" target="_blank">6443@10.110.1.2/,6442@10.110.1.31/00:0F:1F:6E:F3:30</a> kgdbwait<br><br>Now, I&#39;m getting the messages:<br>netconsole: not configured, aborting<br>

kgdboe: eth0 doesn&#39;t support polling, aborting.<br>kgdboe: netpoll_setup failed kgdboe failed<br>&nbsp;<br>And after some lines;<br><br>kgdb: Defering I/O setup to kernel module.<br>kgdb: Waiting for connection from remote gdb...<br>

But then it goes to load ramdisk.<br><br>Can someone please provide some help on this<br><br>thanks<br><br><br>

------=_Part_8667_16878721.1214517204372--
