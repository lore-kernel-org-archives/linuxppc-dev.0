Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (emailhub.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id 1B8C9DDDED
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 16:49:11 +1100 (EST)
Date: Fri, 2 Feb 2007 06:49:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@osdl.org>
Subject: 2.6.20-rc7: known regressions
Message-ID: <20070202054916.GA3754@stusta.de>
References: <Pine.LNX.4.64.0701302019530.11095@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <Pine.LNX.4.64.0701302019530.11095@woody.linux-foundation.org>
Cc: greg@kroah.com, Livio Soares <livio@eecg.toronto.edu>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Jens Axboe <jens.axboe@oracle.com>, alan@lxorguk.ukuu.org.uk,
	linux-usb-devel@lists.sourceforge.net, takada <takada@mbf.nifty.com>,
	=?utf-8?B?RnJhbsOnb2lz?= Valenduc <francois.valenduc@skynet.be>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	ttb@tentacle.dhs.org, jgarzik@pobox.com,
	Prakash Punnoor <prakash@punnoor.de>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Luca Tettamanti <kronos.it@gmail.com>, rml@novell.com,
	linux-ide@vger.kernel.org, petero2@telia.com,
	Oliver Neukum <oliver@neukum.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Berthold Cogel <cogel@rrz.uni-koeln.de>,
	Jordan Crouse <jordan.crouse@amd.com>, Gerhard Dirschl <gd@spherenet.de>,
	Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This email lists some known regressions in 2.6.20-rc7 compared to 2.6.19
that are not yet fixed in Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : NULL pointer dereference at as_move_to_dispatch()
References : http://lkml.org/lkml/2007/1/22/141
Submitter  : Andrew Vasquez <andrew.vasquez@qlogic.com>
Status     : unknown


Subject    : pktcdvd doesn't work with libata pata drivers
References : http://bugzilla.kernel.org/show_bug.cgi?id=7810
             http://lkml.org/lkml/2007/1/25/128
             http://bugzilla.kernel.org/show_bug.cgi?id=7910
             http://lkml.org/lkml/2007/1/30/289
Submitter  : Gerhard Dirschl <gd@spherenet.de>
             Luca Tettamanti <kronos.it@gmail.com>
Caused-By  : Christoph Hellwig <hch@lst.de>
             commit 3b00315799d78f76531b71435fbc2643cd71ae4c
             commit 406c9b605cbc45151c03ac9a3f95e9acf050808c
Status     : unknown


Subject    : powerpc64: performance monitor exception
References : http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030045.html
Submitter  : Livio Soares <livio@eecg.toronto.edu>
Caused-By  : Paul Mackerras <paulus@samba.org>
             commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
Status     : unknown


Subject    : reboot instead of powerdown  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2006/12/25/40
             http://bugzilla.kernel.org/show_bug.cgi?id=7828
Submitter  : Berthold Cogel <cogel@rrz.uni-koeln.de>
             François Valenduc <francois.valenduc@skynet.be>
Handled-By : Alan Stern <stern@rowland.harvard.edu>
Status     : problem is being debugged


Subject    : usb somehow broken  (CONFIG_USB_SUSPEND)
References : http://lkml.org/lkml/2007/1/11/146
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Handled-By : Oliver Neukum <oliver@neukum.org>
             Alan Stern <stern@rowland.harvard.edu>
Status     : problem is being debugged


Subject    : BUG: at fs/inotify.c:172 set_dentry_child_flags()
References : http://bugzilla.kernel.org/show_bug.cgi?id=7785
Submitter  : Cijoml Cijomlovic Cijomlov <cijoml@volny.cz>
Handled-By : Nick Piggin <nickpiggin@yahoo.com.au>
Status     : problem is being debugged


Subject    : fix geode_configure()
References : http://lkml.org/lkml/2007/1/9/216
Submitter  : Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Caused-By  : takada <takada@mbf.nifty.com>
             commit e4f0ae0ea63caceff37a13f281a72652b7ea71ba
Handled-By : takada <takada@mbf.nifty.com>
             Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Status     : patches are being discussed
