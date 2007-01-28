Return-Path: <uwe.bugla@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1AF5DDE1B7
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 00:33:46 +1100 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Sun, 28 Jan 2007 14:33:44 +0100
From: "Uwe Bugla" <uwe.bugla@gmx.de>
In-Reply-To: <20070127174230.GN6017@stusta.de>
Message-ID: <20070128133344.214070@gmx.net>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
	<20070127174230.GN6017@stusta.de>
Subject: Re: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
To: Adrian Bunk <bunk@stusta.de>, akpm@osdl.org, torvalds@linux-foundation.org
Cc: nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org, petero2@telia.com,
	linux-kernel@vger.kernel.org, livio@eecg.toronto.edu,
	B.Zolnierkiewicz@elka.pw.edu.pl, linuxppc-dev@ozlabs.org,
	paulus@samba.org, anton@samba.org, gd@spherenet.de,
	cijoml@volny.cz, ttb@tentacle.dhs.org, rml@novell.com,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Sat, 27 Jan 2007 18:42:30 +0100
Von: Adrian Bunk <bunk@stusta.de>
An: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@osdl.org>
Betreff: 2.6.20-rc6: known unfixed regressions (v2) (part 2)

> This email lists some known regressions in 2.6.20-rc6 compared to 2.6.19
> that are not yet fixed in Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 
> Subject    : problems with CD burning
> References : http://www.spinics.net/lists/linux-ide/msg06545.html
> Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
> Status     : unknown
> 
> 
> Subject    : pktcdvd fails with pata_amd
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7810
>              http://lkml.org/lkml/2007/1/25/128
> Submitter  : Gerhard Dirschl <gd@spherenet.de>
> Caused-By  : Christoph Hellwig <hch@lst.de>
>              commit 3b00315799d78f76531b71435fbc2643cd71ae4c
>              commit 406c9b605cbc45151c03ac9a3f95e9acf050808c
> Status     : problem is being debugged
> 
> 
> Subject    : powerpc64: performance monitor exception
> References :
> http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030045.html
> Submitter  : Livio Soares <livio@eecg.toronto.edu>
> Caused-By  : Paul Mackerras <paulus@samba.org>
>              commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
> Status     : problem is being discussed
> 
> 
> Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
> Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
> Handled-By : Nick Piggin <nickpiggin@yahoo.com.au>
> Status     : problem is being debugged
> 

Hi everybody,
the problem I already reported for earlier release candidates of kernel 2.6.20
(rc1 – 5) unfortunately stills persists.

The regression has become more extreme: While in earlier release candidates nerolinux recognized my burning devices at least after the first start and then never again after all following starts the situation in rc6 is different from that:

The CD and DVD burning devices aren´t recognized even once and the drive seek errors I already reported are still there.

nerolinux runs excellently with kernel 2.6.19.2, but only shows an “image recorder” (i. e. no burning device at all) in kernel 2.6.20-rc6.

Still hope that this terrible bug will not be part of the final version of 2.6.20!

Regards

Uwe

P. S.: I already reported that 2.6.20-rc4-mm1 is not bootable at all.

-- 
Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! 
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
