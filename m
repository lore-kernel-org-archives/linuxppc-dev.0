Message-ID: <20020226131114.89636.qmail@web9704.mail.yahoo.com>
Date: Tue, 26 Feb 2002 05:11:14 -0800 (PST)
From: None Atall <linux_meis@yahoo.com>
Subject: Re: execve system call question
To: Sangmoon Kim <dogoil@etinsys.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <008901c1beb1$409cc7f0$1a11efcb@industrialDiv.hanasys.co.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Well, after that command, the filesystem takes
place. You can't put anything in the kernel. The
procedure for calling and executing init works fine.
Is the root filesystem correct? Have you tried to
upload a ramdisk image in ram? If you are sure that
all these are correct, then do you have a JTAG
Debugger? (OCD Commander ...)

                     D. Meidanis

--- Sangmoon Kim <dogoil@etinsys.com> wrote:
>
> Hi!
> I'm debugging a custom MPC755 board
> with linuxppc_devel from montavista rsync,
> and /opt/hardhat/devkit/ppc/7xx/target for NFS root.
> It booted and stoped after the message.
>
>
--------------------------------------------------------
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 1024 buckets,
> 8Kbytes
> TCP: Hash tables configured (established 8192 bind
> 8192)
> IP-Config: Complete:
>       device=eth0, addr=203.239.17.200,
> mask=255.255.255.0, gw=203.239.17.57,
>      host=dogoil, domain=, nis-domain=(none),
>      bootserver=203.239.17.57,
> rootserver=203.239.17.57, rootpath=
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Looking up port of RPC 100003/2 on 203.239.17.57
> Looking up port of RPC 100005/1 on 203.239.17.57
> VFS: Mounted root (nfs filesystem).
> Freeing unused kernel memory: 76k init
>
--------------------------------------------------------
>
> I traced the code and the point of stopping is after
> calling
> execve("/sbin/init", argv_init, envp_init)
> in init/main.c
>
> I was trying to trace more, but it was impossible
> because of the complexity of the code.
>
> Is there any method to debug this?
> I'm debugging it for a month.
>
> Please help me.
>
> - Sangmoon Kim -
>
>


=====
-------------------------------------------------
  Dhmhtrios Meidanis
-Degree in Mathematics, University of the Aegean.
-Master in Computer Architecture and Digital
 Systems, University of Crete.
  Greece.
-------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
