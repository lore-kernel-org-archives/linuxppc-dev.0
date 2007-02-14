Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id E0E7EDDE3B
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 07:51:22 +1100 (EST)
Message-ID: <45D37644.6020907@freescale.com>
Date: Wed, 14 Feb 2007 14:51:16 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<1171430877.20192.133.camel@localhost.localdomain>
	<45D29EB1.5060801@freescale.com>
	<1171431334.20192.138.camel@localhost.localdomain>
	<45D316CD.9070901@freescale.com>
	<Pine.LNX.4.60.0702142118200.8621@poirot.grange>
	<45D371C0.80805@freescale.com>
	<Pine.LNX.4.60.0702142144280.8621@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0702142144280.8621@poirot.grange>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guennadi Liakhovetski wrote:

>>> Another thing, Timur, if you respin your patch, could you do it against 
>>> the current powerpc.git? There's at least one more .dts there that also 
>>> would need boot-cpu removed - kuroboxHD.dts.
>> My patch already removes linux,boot-cpu from kuroboxHD.dts:
>>
>> diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts 
> 
> "HD" and "HG" are not the same - it's a new file in git now...

Oh, sorry.  I guess I need new glasses.

In that case, I will respin the patch.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
