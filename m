Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 4 May 2004 23:15:08 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Richard Danter <richard.danter@ntlworld.com>
Cc: Wolfgang Denk <wd@denx.de>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Simple module, but won't build
Message-ID: <20040504211508.GA2510@mars.ravnborg.org>
References: <20040504191010.98E50C109F@atlas.denx.de> <4097F32F.6090504@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4097F32F.6090504@ntlworld.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 04, 2004 at 08:46:55PM +0100, Richard Danter wrote:
>
> Command line options are:
>
>   -D__KERNEL__ -DMODULE -Wall -fno-builtins -O -c
>
>

A better approach is to create a small Makefile:
obj-m := rich.o
obj-y :=

Then use:
make -C $KERNELSRCDIR SUBDIRS=$PWD modules

This should give you the correct gcc options.

[Speaking of vanilla kernel, not knowing ELDK in this respect].

	Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
