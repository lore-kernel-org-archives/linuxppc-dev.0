Return-Path: <kylo.ginsberg@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.195])
	by ozlabs.org (Postfix) with ESMTP id 730D167A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 00:50:51 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id g11so645394rne
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 07:50:49 -0700 (PDT)
Message-ID: <61cc712d0504210744951cd92@mail.gmail.com>
Date: Thu, 21 Apr 2005 07:44:09 -0700
From: Kylo Ginsberg <kylo.ginsberg@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050421103234.ED367C1510@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200504211117.25584.Schramel.Linux@go.bartec.de>
	<20050421103234.ED367C1510@atlas.denx.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: mtd mount problem
Reply-To: kylo@kylo.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/21/05, Wolfgang Denk <wd@denx.de> wrote:
> > dev # mount -t jffs2 /dev/mtdblock1 /mnt/Flash1
> > mount: Mounting /dev/mtdblock1 on /mnt/Flash1 failed: No such device
>=20
> Assuming that this is a mount builtin to the  busybox,  this  message
> means  that  there  is  no such file as "/dev/mtdblock1" in your root
> file system - exactly as the error message says.

I believe you can also get "No such device" if you haven't configured
linux for JFFS2 support; another thing to double check in your
.config.

Cheers,
Kylo
