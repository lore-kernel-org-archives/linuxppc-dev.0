Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id B1252DE1F3
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 04:42:22 +1100 (EST)
Date: Sat, 27 Jan 2007 18:42:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@osdl.org>
Subject: 2.6.20-rc6: known unfixed regressions (v2) (part 2)
Message-ID: <20070127174230.GN6017@stusta.de>
References: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0701241847360.25027@woody.linux-foundation.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linuxppc-dev@ozlabs.org,
	petero2@telia.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Livio Soares <livio@eecg.toronto.edu>,
	Uwe Bugla <uwe.bugla@gmx.de>, B.Zolnierkiewicz@elka.pw.edu.pl,
	linux-ide@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	anton@samba.org, Gerhard Dirschl <gd@spherenet.de>,
	Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>,
	ttb@tentacle.dhs.org, rml@novell.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This email lists some known regressions in 2.6.20-rc6 compared to 2.6.19
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : problems with CD burning
References : http://www.spinics.net/lists/linux-ide/msg06545.html
Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
Status     : unknown


Subject    : pktcdvd fails with pata_amd
References : http://bugzilla.kernel.org/show_bug.cgi?id=7810
             http://lkml.org/lkml/2007/1/25/128
Submitter  : Gerhard Dirschl <gd@spherenet.de>
Caused-By  : Christoph Hellwig <hch@lst.de>
             commit 3b00315799d78f76531b71435fbc2643cd71ae4c
             commit 406c9b605cbc45151c03ac9a3f95e9acf050808c
Status     : problem is being debugged


Subject    : powerpc64: performance monitor exception
References : http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030045.html
Submitter  : Livio Soares <livio@eecg.toronto.edu>
Caused-By  : Paul Mackerras <paulus@samba.org>
             commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
Status     : problem is being discussed


Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
Handled-By : Nick Piggin <nickpiggin@yahoo.com.au>
Status     : problem is being debugged
