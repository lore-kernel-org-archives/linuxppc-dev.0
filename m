Return-Path: <castet.matthieu@free.fr>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by ozlabs.org (Postfix) with ESMTP id 2AAB367CE1
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 19:28:00 +1000 (EST)
Received: from smtp2-g19.free.fr (smtp2-g19.free.fr [212.27.42.28])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 2FBCD1A8431
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 10:56:43 +0200 (CEST)
Message-ID: <4528BD47.5030509@free.fr>
Date: Sun, 08 Oct 2006 10:56:39 +0200
From: matthieu castet <castet.matthieu@free.fr>
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc1: known regressions (v2)
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<20061007214620.GB8810@stusta.de>
In-Reply-To: <20061007214620.GB8810@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: alsa-devel@alsa-project.org, Thierry Vignaud <tvignaud@mandriva.com>,
	fastboot@osdl.org, Torsten Kaiser <kernel@bardioc.dyndns.org>,
	ak@suse.de, linux-ide@vger.kernel.org,
	Vivek Goyal <vgoyal@in.ibm.com>, Pavel Machek <pavel@ucw.cz>,
	linux1394-devel@lists.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, Steve Fox <drfickle@us.ibm.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	linux-acpi@vger.kernel.org, Mel Gorman <mel@skynet.ie>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>, jgarzik@pobox.com,
	Prakash Punnoor <prakash@punnoor.de>, len.brown@intel.com,
	Olaf Hering <olaf@aepfle.de>, linux-pm@osdl.org,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Alex Romosan <romosan@sycorax.lbl.gov>, Linus Torvalds <torvalds@osdl.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Antonino Daplas <adaplas@pol.net>, perex@suse.cz,
	discuss@x86-64.org, linux-fbdev-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@oracle.com>, Sukadev Bhattiprolu <sukadev@us.ibm.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	ebiederm@xmission.com, Ernst Herzberg <list-lkml@net4u.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Adrian Bunk wrote:
> This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> that are not yet fixed Linus' tree.
> 
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you was declared guilty for a breakage or I'm considering you in any
> other way possibly involved with one or more of these issues.
> 
> Due to the huge amount of recipients, please trim the Cc when answering.
> 
> 

> 
> Subject    : ueagle-atm Oops
> References : http://lkml.org/lkml/2006/10/6/390
> Submitter  : Ernst Herzberg <list-lkml@net4u.de>
> Handled-By : Matthieu Castet <castet.matthieu@free.fr>
> Status     : unknown
> 
> 
Guilty     :
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=e7ccdfec087f02930c5cdc81143d4a045ae8d361

Patch available at 
https://mail.gna.org/public/ueagleatm-dev/2006-10/msg00022.html , but 
some cleaning is need (I wasn't aware of "USB: fix __must_check warnings 
in drivers/usb/atm/" patch).

Matthieu
