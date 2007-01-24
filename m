Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 11E06DDF24
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 02:47:19 +1100 (EST)
Date: Wed, 24 Jan 2007 16:47:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.20-rc5: known unfixed regressions (v3) (part 2)
Message-ID: <20070124154725.GK17836@stusta.de>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
Cc: Livio Soares <livio@eecg.toronto.edu>, Uwe Bugla <uwe.bugla@gmx.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	alan@lxorguk.ukuu.org.uk, takada <takada@mbf.nifty.com>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	ttb@tentacle.dhs.org, jgarzik@pobox.com,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Malte =?utf-8?B?U2NocsO2ZGVy?= <MalteSch@gmx.de>,
	David Chinner <dgc@sgi.com>, xfs-masters@oss.sgi.com,
	rml@novell.com, Sami Farin <7atbggg02@sneakemail.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	linux-ide@vger.kernel.org, petero2@telia.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jordan Crouse <jordan.crouse@amd.com>, gd@spherenet.de,
	Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>, reiserfs-dev@namesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This email lists some known regressions in 2.6.20-rc5 compared to 2.6.19
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : pktcdvd fails with pata_amd
References : http://bugzilla.kernel.org/show_bug.cgi?id=7810
Submitter  : gd@spherenet.de
Status     : unknown


Subject    : problems with CD burning
References : http://www.spinics.net/lists/linux-ide/msg06545.html
Submitter  : Uwe Bugla <uwe.bugla@gmx.de>
Status     : unknown


Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
Handled-By : Nick Piggin <nickpiggin@yahoo.com.au>
Status     : problem is being debugged


Subject    : powerpc64: performance monitor exception
References : http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030045.html
Submitter  : Livio Soares <livio@eecg.toronto.edu>
Caused-By  : Paul Mackerras <paulus@samba.org>
             commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
Status     : problem is being discussed


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (reiserfs)
References : http://lkml.org/lkml/2007/1/7/117
             http://lkml.org/lkml/2007/1/10/202
Submitter  : Malte Schröder <MalteSch@gmx.de>
Handled-By : Vladimir V. Saveliev <vs@namesys.com>
             Nick Piggin <nickpiggin@yahoo.com.au>
Patch      : http://lkml.org/lkml/2007/1/10/202
Status     : problem is being discussed


Subject    : BUG: at mm/truncate.c:60 cancel_dirty_page()  (XFS)
References : http://lkml.org/lkml/2007/1/5/308
             http://lkml.org/lkml/2007/1/23/190
             http://lkml.org/lkml/2007/1/23/192
Submitter  : Sami Farin <7atbggg02@sneakemail.com>
Handled-By : David Chinner <dgc@sgi.com>
Status     : patches are being discussed


Subject    : fix geode_configure()
References : http://lkml.org/lkml/2007/1/9/216
Submitter  : Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Caused-By  : takada <takada@mbf.nifty.com>
             commit e4f0ae0ea63caceff37a13f281a72652b7ea71ba
Handled-By : takada <takada@mbf.nifty.com>
             Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Status     : patches are being discussed


Subject    : NFS triggers WARN_ON() in invalidate_inode_pages2_range()
References : http://bugzilla.kernel.org/show_bug.cgi?id=7826
Submitter  : Andrew Clayton <andrew@digital-domain.net>
Caused-By  : Andrew Morton <akpm@osdl.org>
             commit 8258d4a574d3a8c01f0ef68aa26b969398a0e140
Handled-By : Trond Myklebust <trond.myklebust@fys.uio.no>
Status     : Trond: the WARN_ON() needs to be thrown out
