Return-Path: <SRS0=9ZSp=SG=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id A1628DDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 00:01:39 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] 4xx: Remove "i2c" and "xxmii-interface"
	device_types from dts
Date: Wed, 16 Jan 2008 14:01:22 +0100
References: <1200474000-5630-1-git-send-email-sr@denx.de>
	<20080116064008.390db210@zod.rchland.ibm.com>
In-Reply-To: <20080116064008.390db210@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801161401.22855.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh,

On Wednesday 16 January 2008, Josh Boyer wrote:
> > Remove all "i2c" and "xxmii-interface" (rgmii etc) device_type entries
> > from the 4xx dts files.
>
> Holding on this one until Ben or I can check Axon to see if it's DT can
> handle no device_type for xxmii-interface.

Best would be, if you would hold this patch at least until the newemac patch 
is pulled.

Best regards,
Stefan
