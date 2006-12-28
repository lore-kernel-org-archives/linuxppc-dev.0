Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id 4615ADDF15
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Dec 2006 09:31:49 +1100 (EST)
Date: Thu, 28 Dec 2006 23:31:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: 2.6.20-rc2: known regressions with patches available
Message-ID: <20061228223150.GJ20714@stusta.de>
References: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0612232043030.3671@woody.osdl.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>, petero2@telia.com,
	Paul Moore <paul.moore@hp.com>, linuxppc-dev@ozlabs.org,
	"Adam J. Richter" <adam@yggdrasil.com>,
	Ben Collins <ben.collins@ubuntu.com>, jmorris@namei.org,
	Avi Kivity <avi@qumranet.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kvm-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Yu Luming <luming.yu@gmail.com>, Martin Pitt <martin.pitt@ubuntu.com>,
	Michael Bommarito <mjbommar@umich.edu>,
	Larry Finger <Larry.Finger@lwfinger.net>, sds@tycho.nsa.gov,
	Parag Warudkar <paragw@paragw.zapto.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This email lists some known regressions in 2.6.20-rc2 compared to 2.6.19
with patches available

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you caused a breakage or I'm considering you in any other way possibly
involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : selinux networking: sleeping function called from invalid context
References : http://lkml.org/lkml/2006/12/24/78
Submitter  : "Adam J. Richter" <adam@yggdrasil.com>
Caused-By  : Paul Moore <paul.moore@hp.com>
Handled-By : Parag Warudkar <paragw@paragw.zapto.org>
Patch      : http://lkml.org/lkml/2006/12/24/89
Status     : patch available


Subject    : KVM Oops
References : http://lkml.org/lkml/2006/12/27/171
Submitter  : Parag Warudkar <kernel-stuff@comcast.net>
Handled-By : Avi Kivity <avi@qumranet.com>
Status     : patch available


Subject    : drivers/macintosh/via-pmu-backlight.c compilation broken
References : http://lkml.org/lkml/2006/12/24/49
Submitter  : Andreas Schwab <schwab@suse.de>
Caused-By  : Yu Luming <luming.yu@gmail.com>
             commit 519ab5f2be65b72cf12ae99c89752bbe79b44df6
Handled-By : Andreas Schwab <schwab@suse.de>
Patch      : http://lkml.org/lkml/2006/12/24/49
Status     : patch available


Subject    : NULL dereference in ieee80211softmac_get_network_by_bssid_locked
             ieee80211softmac_wx.c typo: mutex_lock -> mutex_unlock
References : http://bugzilla.kernel.org/show_bug.cgi?id=7657
             http://lkml.org/lkml/2006/12/16/141
             http://lkml.org/lkml/2006/12/24/43
Submitter  : Michael Bommarito <mjbommar@umich.edu>
             Ben Collins <ben.collins@ubuntu.com>
             Martin Pitt <martin.pitt@ubuntu.com>
Handled-By : Michael Bommarito <mjbommar@umich.edu>
             Larry Finger <Larry.Finger@lwfinger.net
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7657
Status     : patches available


Subject    : BUG at drivers/scsi/scsi_lib.c:1118 by "pktsetup dvd /dev/sr0"
References : http://bugzilla.kernel.org/show_bug.cgi?id=7667
Submitter  : Laurent Riffard <laurent.riffard@free.fr>
Caused-By  : Christoph Hellwig <hch@lst.de>
             commit 3b00315799d78f76531b71435fbc2643cd71ae4c
Handled-By : Christoph Hellwig <hch@lst.de>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7667
Status     : patch available
