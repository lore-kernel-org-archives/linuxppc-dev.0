Date: Thu, 15 Apr 2004 09:36:01 -0700
From: Brad Boyer <flar@allandria.com>
To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Any hints on custom keyboard driver?
Message-ID: <20040415163601.GA19251@pants.nu>
References: <407B6736.9090607@nortelnetworks.com> <20040415152453.85184.qmail@web15202.mail.bjs.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040415152453.85184.qmail@web15202.mail.bjs.yahoo.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Apr 15, 2004 at 11:24:53PM +0800, Song Sam wrote:
> My Puzzles:
> 1. Should I use input.o as interactive interface to
> communicate with kernel & user space for convenience?

If you want to use this keyboard for your console, then the easiest
way would be to create an input layer driver. I think USB and ADB
are the only keyboard drivers using the input layer in 2.4, but
just about everything is using it in 2.6.

> 2. Is there any clue on how to code a standard input
> driver?Or any reference in this aspect?

There is some documentation in the kernel source. Take a look at
the stuff in Documentation/input/.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
