Return-Path: <seema.pm@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 2E382DE0A3
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 06:46:26 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so224650pyg.27
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 13:46:24 -0700 (PDT)
Message-ID: <4e69a5150806271346m77c26d2cp8d583ae87d13c235@mail.gmail.com>
Date: Fri, 27 Jun 2008 13:46:22 -0700
From: "SEEMA pm" <seema.pm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: issue with kgdb on ppc
In-Reply-To: <4e69a5150806261453n1196b5b8va61e330ea57bb00e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_17546_29772835.1214599584112"
References: <4e69a5150806261453n1196b5b8va61e330ea57bb00e@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_17546_29772835.1214599584112
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello

I got the gianfar.c patch and  enabled CONFIG_NETCONSOLE and now i'm able to
connect kgdb and gdb.
But when i try to cont in gdb, the system tries to load the rootfs but fails
and trys to reboot. Can someone please provide some help on this.
dump:

(gdb) c
Continuing.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
VFS: Cannot open root device "ram=rw" or unknown-block(2,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
        total:    used:    free:  shared: buffers:  cached:
Mem:  1060827136 226791424 834035712        0 219955200     8192
Swap:        0        0        0
MemTotal:      1035964 kB
MemFree:        814488 kB
MemShared:           0 kB
Buffers:        214800 kB
Cached:              8 kB
SwapCached:          0 kB
Active:              0 kB
Inactive:            0 kB
HighTotal:     1035964 kB
HighFree:       814488 kB
LowTotal:            0 kB
LowFree:             0 kB
SwapTotal:        8192 kB
SwapFree:            0 kB
 [New Thread 1]

Program received signal SIGTRAP, Trace/breakpoint trap.
0x8003c0d8 in breakpoint () at kernel/kgdb.c:1773
1773            wmb();
(gdb)

Thanks

On Thu, Jun 26, 2008 at 2:53 PM, SEEMA pm <seema.pm@gmail.com> wrote:

> Hello
>
> I'm trying to get kgdb working on a mpc8540 based target machine. I took
> the latest patches which are for 2.6.13(mine is 2.6.11) and build and made
> changes to config by enabling :
> - Compile the kernel with debug info
> - KGDB: kernel debugging with remote gdb
> - KGDB: Console messages through gdb
> - Method for KGDB communication (KGDB: On ethernet - in kernel)
>
> I also added bootargs through uboot as:
> kgdboe=6443@10.110.1.2/,6442@10.110.1.31/00:0F:1F:6E:F3:30 kgdbwait
>
> Now, I'm getting the messages:
> netconsole: not configured, aborting
> kgdboe: eth0 doesn't support polling, aborting.
> kgdboe: netpoll_setup failed kgdboe failed
>
> And after some lines;
>
> kgdb: Defering I/O setup to kernel module.
> kgdb: Waiting for connection from remote gdb...
> But then it goes to load ramdisk.
>
> Can someone please provide some help on this
>
> thanks
>
>
>

------=_Part_17546_29772835.1214599584112
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello<br><br>I got the gianfar.c patch and&nbsp; enabled CONFIG_NETCONSOLE and now i&#39;m able to connect kgdb and gdb.<br>But when i try to cont in gdb, the system tries to load the rootfs but fails and trys to reboot. Can someone please provide some help on this.<br>
dump:<br><br>(gdb) c<br>Continuing.<br>RAMDISK: Compressed image found at block 0<br>VFS: Mounted root (ext2 filesystem).<br>Root-NFS: No NFS server available, giving up.<br>VFS: Unable to mount root fs via NFS, trying floppy.<br>
VFS: Cannot open root device &quot;ram=rw&quot; or unknown-block(2,0)<br>Please append a correct &quot;root=&quot; boot option<br>Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(2,0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; total:&nbsp;&nbsp;&nbsp; used:&nbsp;&nbsp;&nbsp; free:&nbsp; shared: buffers:&nbsp; cached:<br>
Mem:&nbsp; 1060827136 226791424 834035712&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 219955200&nbsp;&nbsp;&nbsp;&nbsp; 8192<br>Swap:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>MemTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1035964 kB<br>MemFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 814488 kB<br>MemShared:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>Buffers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 214800 kB<br>Cached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8 kB<br>
SwapCached:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>Active:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>Inactive:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>HighTotal:&nbsp;&nbsp;&nbsp;&nbsp; 1035964 kB<br>HighFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 814488 kB<br>LowTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>LowFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>SwapTotal:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8192 kB<br>
SwapFree:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 kB<br>&nbsp;[New Thread 1]<br><br>Program received signal SIGTRAP, Trace/breakpoint trap.<br>0x8003c0d8 in breakpoint () at kernel/kgdb.c:1773<br>1773&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wmb();<br>(gdb)<br><br>Thanks<br><br><div class="gmail_quote">
On Thu, Jun 26, 2008 at 2:53 PM, SEEMA pm &lt;<a href="http://seema.pm">seema.pm</a>@<a href="http://gmail.com">gmail.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hello<br><br>I&#39;m
trying to get kgdb working on a mpc8540 based target machine. I took
the latest patches which are for 2.6.13(mine is 2.6.11) and build and
made changes to config by enabling :<br>
- Compile the kernel with debug info<br>- KGDB: kernel debugging with remote gdb <br>- KGDB: Console messages through gdb<br>- Method for KGDB communication (KGDB: On ethernet - in kernel)<br><br>I also added bootargs through uboot as:<br>


kgdboe=<a href="http://6443@10.110.1.2/,6442@10.110.1.31/00:0F:1F:6E:F3:30" target="_blank">6443@10.110.1.2/,6442@10.110.1.31/00:0F:1F:6E:F3:30</a> kgdbwait<br><br>Now, I&#39;m getting the messages:<br>netconsole: not configured, aborting<br>


kgdboe: eth0 doesn&#39;t support polling, aborting.<br>kgdboe: netpoll_setup failed kgdboe failed<br>&nbsp;<br>And after some lines;<br><br>kgdb: Defering I/O setup to kernel module.<br>kgdb: Waiting for connection from remote gdb...<br>


But then it goes to load ramdisk.<br><br>Can someone please provide some help on this<br><br>thanks<br><br><br>
</blockquote></div><br>

------=_Part_17546_29772835.1214599584112--
