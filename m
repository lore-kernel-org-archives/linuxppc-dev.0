Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Tue, 28 May 2002 15:21:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stephen Cameron <steve.cameron@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bitkeeper trouble
Message-ID: <20020528222106.GC5997@opus.bloom.county>
References: <20020528165639.A28325@zuul.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020528165639.A28325@zuul.cca.cpqcorp.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 04:56:39PM -0500, Stephen Cameron wrote:
>
> "bk pull" used to work, (1 week ago) but
> now fails for me.
>
> [scameron@zuul lxppc24d]$ bk pull
> drainErrorMsg: Unexpected response:
> <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">
>
> Anybody else seeing that?
>
> [scameron@zuul lxppc24d]$ bk version
> BitKeeper/Free version is bk-2.1.6-pre5 20020330075529 for x86-glibc21-linux
> Built by: lm@redhat62.bitmover.com in /usr/build/bk-2.1.x-lm/src
> Built on: Sat Mar 30 00:29:33 PST 2002
> [scameron@zuul lxppc24d]$ cat BitKeeper/*/parent
> http://ppc.bkserver.net/linuxppc_2_4_devel
>
> Do I need a newer version of bitkeeper?
> I didn't see one around.

What does 'bk parent' say?  If it's not
bk://ppc.bkbits.net/linuxppc_2_4_devel, try doing:
bk parent bk://ppc.bkbits.net/linuxppc_2_4_devel
and then pulling again.  I'm not sure why, but ppc.bkserver.net seems to
be gone.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
