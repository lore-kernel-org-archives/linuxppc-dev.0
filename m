Return-Path: <timur.tabi@gmail.com>
Received: from mail-qy0-f110.google.com (mail-qy0-f110.google.com
	[209.85.221.110]) by ozlabs.org (Postfix) with ESMTP id 316CDDDEEB
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 07:34:38 +1000 (EST)
Received: by qyk8 with SMTP id 8so5063105qyk.17
	for <linuxppc-dev@ozlabs.org>; Mon, 06 Apr 2009 14:34:37 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C071F4271@SDCEXCHANGE01.ad.amcc.com>
References: <22655709.post@talk.nabble.com> <22722574.post@talk.nabble.com>
	<AC5E1C3367E37D44970B81A6ADD1DA2C071F4271@SDCEXCHANGE01.ad.amcc.com>
Date: Mon, 6 Apr 2009 16:34:36 -0500
Message-ID: <ed82fe3e0904061434t52be80f8j893097d76d3a7967@mail.gmail.com>
Subject: Re: sata device failed to IDENTIFY...
From: Timur Tabi <timur@freescale.com>
To: Tirumala Reddy Marri <tmarri@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, rizwan ahmad <rizwanamu@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 23, 2009 at 3:07 AM, rizwan ahmad <rizwanamu@gmail.com> wrote:
> ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata1.00: qc timeout (cmd 0xec)
> ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)

I'm seeing the same exact thing on a Freescale MPC8610 HPCD board.
This happens only on 2.6.30.  It works fine on 2.6.29.

Unfortunately, my rootfs is on my SATA drive, so it will be a bit
difficult to boot and get an lspci output.
