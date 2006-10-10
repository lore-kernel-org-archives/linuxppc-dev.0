Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17708.9637.569670.824121@cargo.ozlabs.ibm.com>
Date: Wed, 11 Oct 2006 08:58:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc1: known regressions (v3)
In-Reply-To: <20061010051019.GB3650@stusta.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<20061010051019.GB3650@stusta.de>
Cc: alsa-devel@alsa-project.org, Thierry Vignaud <tvignaud@mandriva.com>,
	Torsten Kaiser <kernel@bardioc.dyndns.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Andrew de Quincey <adq_dvb@lidskialf.net>,
	Vivek Goyal <vgoyal@in.ibm.com>, Jens Axboe <jens.axboe@oracle.com>,
	linux-usb-devel@lists.sourceforge.net,
	Steve Fox <drfickle@us.ibm.com>, lm-sensors@lm-sensors.org,
	art@usfltd.com, Mel Gorman <mel@skynet.ie>,
	Michael Krufky <mkrufky@linuxtv.org>,
	Sylvain BERTRAND <sylvain.bertrand@gmail.com>, jgarzik@pobox.com,
	Prakash Punnoor <prakash@punnoor.de>, fastboot@osdl.org,
	Olaf Hering <olaf@aepfle.de>, discuss@x86-64.org,
	Trond Myklebust <Trond.Myklebust@netapp.com>,
	Alex Romosan <romosan@sycorax.lbl.gov>, Linus Torvalds <torvalds@osdl.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>, Antonino Daplas <adaplas@pol.net>,
	v4l-dvb-maintainer@linuxtv.org,
	Johannes Berg <johannes@sipsolutions.net>, perex@suse.cz,
	linux-pm@osdl.org, linux-fbdev-devel@lists.sourceforge.net,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>, ak@suse.de,
	Sukadev Bhattiprolu <sukadev@us.ibm.com>, ebiederm@xmission.com,
	Matthieu Castet <castet.matthieu@free.fr>,
	Jean Delvare <khali@linux-fr.org>, pavel@suse.cz,
	Ernst Herzberg <list-lkml@net4u.de>,
	David Hubbard <david.c.hubbard@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk writes:

> Subject    : sleep/wakeup on powerbooks apparently busted
> References : http://lkml.org/lkml/2006/10/5/13
> Submitter  : Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Handled-By : Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Status     : Benjamin will investigate

Should be fixed once Linus pulls the powerpc.git tree.

Paul.
