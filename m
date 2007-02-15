Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 10CDADDD08
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 04:11:13 +1100 (EST)
Message-ID: <45D49406.9010505@freescale.com>
Date: Thu, 15 Feb 2007 11:10:30 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [PATCH 15/16] Add device tree for Ebony
References: <20070213061026.5837FDDDE9@ozlabs.org><e9a2d2be6fe9006c1e2e0b65099a1854@kernel.crashing.org><20070214002210.GE11491@localhost.localdomain><45afe653a3f963e21e58a063c09b1b22@kernel.crashing.org><20070214231734.GC16279@localhost.localdomain><90e2bb990b7e1f46c6eaccd1d9255d77@kernel.crashing.org><E1HHhCD-0004Hf-QT@jdl.com>	<865018a527ef1056f628250167301e64@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1BAF0@az33exm25.fsl.freescale.net>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1BAF0@az33exm25.fsl.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yoder Stuart-B08248 wrote:
> 1275 specifies whitespace inbetween, but isn't this due to 
> the way they are describing things for the forth / stack-based
> operations?
> 
> I would prefer in the DTS files to have no whitespace in 
> between--  <d#1234 #h5678> seems much more readable
> than <d# 1234 #h 5678>.
> 
> Or even better-- just use standard C notation
>     <1234 0x5678>
> 
> That is very readable.  Why bring unnecessary complexity into
> this?

Decimal-by-default C notation would break compatibility (undetectably, 
in the case of hex constants that don't happen to use digits above 9) 
with current DTS files which are hex-by-default -- and besides, most of 
the values are going to be hex.

I agree that allowing the space to be omitted would be a good thing.

-Scott
