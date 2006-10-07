Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id BD21767BF5
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 07:46:28 +1000 (EST)
Date: Sat, 7 Oct 2006 23:46:21 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: 2.6.19-rc1: known regressions (v2)
Message-ID: <20061007214620.GB8810@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
Cc: alsa-devel@alsa-project.org, Thierry Vignaud <tvignaud@mandriva.com>,
	fastboot@osdl.org, Torsten Kaiser <kernel@bardioc.dyndns.org>,
	ak@suse.de, linux-ide@vger.kernel.org,
	Vivek Goyal <vgoyal@in.ibm.com>, Pavel Machek <pavel@ucw.cz>,
	linux1394-devel@lists.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, Steve Fox <drfickle@us.ibm.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>, art@usfltd.com,
	linux-acpi@vger.kernel.org, Mel Gorman <mel@skynet.ie>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>, jgarzik@pobox.com,
	Prakash Punnoor <prakash@punnoor.de>, len.brown@intel.com,
	Olaf Hering <olaf@aepfle.de>, linux-pm@osdl.org,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Alex Romosan <romosan@sycorax.lbl.gov>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Antonino Daplas <adaplas@pol.net>, perex@suse.cz,
	discuss@x86-64.org, linux-fbdev-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@oracle.com>, Sukadev Bhattiprolu <sukadev@us.ibm.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	ebiederm@xmission.com, Matthieu Castet <castet.matthieu@free.fr>,
	Ernst Herzberg <list-lkml@net4u.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
that are not yet fixed Linus' tree.

If you find your name in the Cc header, you are either submitter of one
of the bugs, maintainer of an affectected subsystem or driver, a patch
of you was declared guilty for a breakage or I'm considering you in any
other way possibly involved with one or more of these issues.

Due to the huge amount of recipients, please trim the Cc when answering.


Subject    : SMP x86_64 boot problem
References : http://lkml.org/lkml/2006/9/28/330
             http://lkml.org/lkml/2006/10/5/289
Submitter  : art@usfltd.com
Status     : submitter was asked to git bisect
             result of bisecting seems to be wrong


Subject    : snd-hda-intel <-> forcedeth MSI problem
References : http://lkml.org/lkml/2006/10/5/40
Submitter  : Prakash Punnoor <prakash@punnoor.de>
Status     : unknown


Subject    : oops in xfrm_register_mode
References : http://lkml.org/lkml/2006/10/4/170
Submitter  : Steve Fox <drfickle@us.ibm.com>
Status     : unknown


Subject    : T60 stops triggering any ACPI events
References : http://lkml.org/lkml/2006/10/4/425
Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
Status     : unknown


Subject    : thinkpad x60: brightness no longer adjustable in 2.6.18-git
References : http://lkml.org/lkml/2006/10/2/300
Submitter  : Pavel Machek <pavel@ucw.cz>
Status     : unknown, related to the issue above?


Subject    : monitor not active after boot
References : http://lkml.org/lkml/2006/10/5/338
Submitter  : Olaf Hering <olaf@aepfle.de>
Guilty     : Antonino Daplas <adaplas@pol.net>
             commit 346bc21026e7a92e1d7a4a1b3792c5e8b686133d
Status     : unknown


Subject    : sata-via doesn't detect anymore disks attached to VIA vt6421
References : http://bugzilla.kernel.org/show_bug.cgi?id=7255
Submitter  : Thierry Vignaud <tvignaud@mandriva.com>
Status     : unknown


Subject    : ueagle-atm Oops
References : http://lkml.org/lkml/2006/10/6/390
Submitter  : Ernst Herzberg <list-lkml@net4u.de>
Handled-By : Matthieu Castet <castet.matthieu@free.fr>
Status     : unknown


Subject    : DVD drive lost DVD capabilities
References : http://lkml.org/lkml/2006/10/1/45
Submitter  : Olaf Hering <olaf@aepfle.de>
Guilty     : Jens Axboe <axboe@oracle.com>
             commit 4aff5e2333c9a1609662f2091f55c3f6fffdad36
Handled-By : Jens Axboe <axboe@oracle.com>
Status     : Jens is working on a fix


Subject    : sleep/wakeup on powerbooks apparently busted
References : http://lkml.org/lkml/2006/10/5/13
Submitter  : Benjamin Herrenschmidt <benh@kernel.crashing.org>
Handled-By : Benjamin Herrenschmidt <benh@kernel.crashing.org>
Status     : Benjamin will investigate


Subject    : doesn't boot on iBook G4
References : http://lkml.org/lkml/2006/10/5/305
Submitter  : Andreas Schwab <schwab@suse.de>
Handled-By : Mel Gorman <mel@skynet.ie>
Patch      : http://lkml.org/lkml/2006/10/6/80
Status     : patch available


Subject    : airo suspend fails
References : http://lkml.org/lkml/2006/10/6/3
Submitter  : Alex Romosan <romosan@sycorax.lbl.gov>
Guilty     : Sukadev Bhattiprolu <sukadev@us.ibm.com>  (?)
             commit 3b4c7d640376dbccfe80fc4f7b8772ecc7de28c5  (?)
Handled-By : Dave Kleikamp <shaggy@austin.ibm.com>
Patch      : http://lkml.org/lkml/2006/10/7/139
Status     : patch available


Subject    : NFSv4 fails to mount (timeout)
References : http://bugzilla.kernel.org/show_bug.cgi?id=7274
Submitter  : Torsten Kaiser <kernel@bardioc.dyndns.org>
Guilty     : Trond Myklebust <Trond.Myklebust@netapp.com>
             commit 51b6ded4d9a94a61035deba1d8f51a54e3a3dd86
Handled-By : Trond Myklebust <Trond.Myklebust@netapp.com>
Patch      : http://bugzilla.kernel.org/show_bug.cgi?id=7274
Status     : patch available


Subject    : kexec broken on x86_64
References : http://lkml.org/lkml/2006/10/5/86
Submitter  : Magnus Damm <magnus.damm@gmail.com>
Handled-By : Vivek Goyal <vgoyal@in.ibm.com>
Patch      : http://lkml.org/lkml/2006/10/5/199
Status     : patch available


Subject    : strange ieee1394 messages
References : http://lkml.org/lkml/2006/10/5/154
Submitter  : "Alistair John Strachan" <s0348365@sms.ed.ac.uk>
Guilty     : Stefan Richter <stefanr@s5r6.in-berlin.de>
             commit d2f119fe319528da8c76a1107459d6f478cbf28c
Handled-By : Stefan Richter <stefanr@s5r6.in-berlin.de>
Patch      : http://lkml.org/lkml/2006/10/6/235
Status     : harmless, patch available
