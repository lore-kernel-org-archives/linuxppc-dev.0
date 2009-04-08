Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25A78DE092
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Apr 2009 07:08:41 +1000 (EST)
Message-ID: <49DD11D1.7060105@freescale.com>
Date: Wed, 08 Apr 2009 16:06:25 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Tejun Heo <tj@kernel.org>
Subject: Re: "ahci: drop intx manipulation on msi enable" breaks ULI M1575
References: <49DB6914.1030107@freescale.com> <49DBE858.9040004@kernel.org>	
	<ed82fe3e0904071736w55dff582y8ac2681f6410865b@mail.gmail.com>	
	<1239156559.10104.7.camel@localhost>
	<ed82fe3e0904080440w130b5dc5of6d5ed3051ed04e2@mail.gmail.com>
	<49DD1154.3040106@kernel.org>
In-Reply-To: <49DD1154.3040106@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
	Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tejun Heo wrote:

> Running "lspci -nnvvvxxx" before loading the driver should be enough.

That might be difficult.  My root file system is on my SATA drive.
It'll be a while before I can build an NFS rootfs.

-- 
Timur Tabi
Linux kernel developer at Freescale
