Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 792842C007D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2012 22:57:03 +1100 (EST)
Date: Wed, 21 Nov 2012 11:51:14 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Bill Pemberton <wfp5p@virginia.edu>
Subject: Re: [PATCH 192/493] scsi: remove use of __devinit
Message-ID: <20121121115114.GF3290@n2100.arm.linux.org.uk>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-192-git-send-email-wfp5p@virginia.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353349642-3677-192-git-send-email-wfp5p@virginia.edu>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Oliver Neukum <oliver@neukum.org>,
 VMware PV-Drivers <pv-drivers@vmware.com>, Kurt Garloff <garloff@suse.de>,
 Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
 GOTO Masanori <gotom@debian.or.jp>, linux-scsi@vger.kernel.org,
 Jamie Lenehan <lenehan@twibble.org>, osst-users@lists.sourceforge.net,
 Michael Reed <mdr@sgi.com>, cbe-oss-dev@lists.ozlabs.org,
 iss_storagedev@hp.com, Matthew Wilcox <matthew@wil.cx>,
 Ali Akcaagac <aliakc@web.de>, dc395x@twibble.org,
 linux-arm-kernel@lists.infradead.org, Neela Syam Kolli <megaraidlinux@lsi.com>,
 Geoff Levand <geoff@infradead.org>, gregkh@linuxfoundation.org,
 Arvind Kumar <arvindkumar@vmware.com>,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Willem Riede <osst@riede.org>, YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>,
 linuxppc-dev@lists.ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2012 at 01:22:21PM -0500, Bill Pemberton wrote:
>  drivers/scsi/arm/acornscsi.c              |  2 +-
>  drivers/scsi/arm/arxescsi.c               |  2 +-
>  drivers/scsi/arm/cumana_1.c               |  2 +-
>  drivers/scsi/arm/cumana_2.c               |  2 +-
>  drivers/scsi/arm/eesox.c                  |  2 +-
>  drivers/scsi/arm/oak.c                    |  2 +-
>  drivers/scsi/arm/powertec.c               |  2 +-

For these,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
