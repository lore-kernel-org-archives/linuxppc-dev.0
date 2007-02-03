Return-Path: <bunk@stusta.de>
Received: from mailhub.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with ESMTP id D60DBDDDFF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Feb 2007 11:44:45 +1100 (EST)
Date: Sat, 3 Feb 2007 01:44:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: 2.6.20-rc7: known regressions (v2) (part 1)
Message-ID: <20070203004447.GJ3754@stusta.de>
References: <Pine.LNX.4.64.0701302019530.11095@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0701302019530.11095@woody.linux-foundation.org>
Cc: Livio Soares <livio@eecg.toronto.edu>, linux-ide@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <jens.axboe@oracle.com>,
	Allen Parker <parker@isohunt.com>, alan@lxorguk.ukuu.org.uk,
	jesse.brandeburg@intel.com, mingo@redhat.com,
	jeffrey.t.kirsher@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	jgarzik@pobox.com, cramerj@intel.com,
	Andrew Vasquez <andrew.vasquez@qlogic.com>,
	Luca Tettamanti <kronos.it@gmail.com>, anton@samba.org,
	Auke Kok <auke-jan.h.kok@intel.com>, linuxppc-dev@ozlabs.org,
	petero2@telia.com, netdev@vger.kernel.org, gregkh@suse.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	john.ronciak@intel.com, ebiederm@xmission.com,
	Gerhard Dirschl <gd@spherenet.de>,
	Adam Kropelin <akropel1@rochester.rr.com>
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
             (caused by scsi_lib and pktcdvd patches)
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


Subject    : e1000: 82571EB/82572EI PCI-E cards: link is always down
             (MSI related)
References : http://lkml.org/lkml/2007/1/16/27
             http://lkml.org/lkml/2007/1/17/182
Submitter  : Allen Parker <parker@isohunt.com>
             Adam Kropelin <akropel1@rochester.rr.com>
Handled-By : Auke Kok <auke-jan.h.kok@intel.com>
Status     : problem is being debugged


Subject    : powerpc64: performance monitor exception
References : http://ozlabs.org/pipermail/linuxppc-dev/2007-January/030045.html
Submitter  : Livio Soares <livio@eecg.toronto.edu>
Caused-By  : Paul Mackerras <paulus@samba.org>
             commit d04c56f73c30a5e593202ecfcf25ed43d42363a2
Status     : unknown
