Date: Tue, 26 Feb 2002 14:27:06 +0100 (CET)
From: Christian Pellegrin <chri@infis.univ.trieste.it>
To: Sangmoon Kim <dogoil@etinsys.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: execve system call question
In-Reply-To: <008901c1beb1$409cc7f0$1a11efcb@industrialDiv.hanasys.co.kr>
Message-ID: <Pine.LNX.4.44.0202261423220.23446-100000@sole.infis.univ.trieste.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 26 Feb 2002, Sangmoon Kim wrote:

>
> and /opt/hardhat/devkit/ppc/7xx/target for NFS root.

> VFS: Mounted root (nfs filesystem).
>
> Is there any method to debug this?
> I'm debugging it for a month.
>

I'll suggest:

1) turn on debugging on the nfs server

2) generate a trivial hello world program and put it instead of
/sbin/init. So to be sure it's a ppc executable. Start with a static
linked one,it's a bit difficult to do dynamic linking right at the first
time ;-)

Bye!


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
