Date: Wed, 26 Apr 2000 20:06:01 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Alain Birtz <abz@videotron.ca>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel recompile: asm-m68k, setup.h and amiga??.h files
In-Reply-To: <3907052D.6B4FC950@videotron.ca>
Message-ID: <Pine.LNX.4.10.10004262004320.30203-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> make vmlinux complaint first for setup.h file not in asm-m68k.
> To fix it I create a symbolic link to asm-ppc. (Is it OK ?)

Nope. Please shout in someone's ear at LinuxPPC: Bad things will happen if
you just strip the kernel source from apparently unnecessary stuff like
other arch's includes.

Get a real kernel source.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
