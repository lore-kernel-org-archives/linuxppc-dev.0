Return-Path: <markc@mail.com>
Received: from relay03.roc.ny.frontiernet.net (relay03.roc.ny.frontiernet.net
	[66.133.131.36]) by ozlabs.org (Postfix) with ESMTP id B5C8A2BDB2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 23:21:21 +1000 (EST)
Message-ID: <002001c4a627$7575db50$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <jonathan@jonmasters.org>,
	"Piotr Perak" <peri@aqua.aspd.pwr.wroc.pl>
References: <20040928094327.B1532@home.com><Pine.LNX.4.21.0409291256250.3154-100000@aqua.aspd.pwr.wroc.pl>
	<35fb2e59040929045822511b4b@mail.gmail.com>
Date: Wed, 29 Sep 2004 09:22:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x on 405CR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > Porting 2.6.8.1 to their board is my project. I was told that they have
some
> > hardware debbuger, but it doesn't work with virtual memory.
>
> I don't have one capable of working with virtual memory but I do have
> a JTAG debugger since JTAG is used to program all of our boards - and
> using insight with a large cup of coffee, System.map and the output of
> a full objdump of the kernel binary in combination with modifying the
> code in memory to insert infinate loops or changing the mode in the
> MSR usually works for me. Seriously, if you don't have a vm capable
> debugger that's a lot of masochistic fun to be had debugging.
>

And just to make the point - it's not the JTAG hardware which is or is not
VM capable, it's the debugger using the hardware which must be smart
enough to read the MM tables and do the translations for you. Maybe if you
post what hardware you have somebody would know of a gdb port that
supports it.  Don't let them blow you off on this - they're wasting your
time
and their money if you don't have a proper debugger.  Just tell them we all
said you need one.

Mark C.
