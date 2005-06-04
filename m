Return-Path: <tnt@246tNt.com>
Received: from outmx001.isp.belgacom.be (outmx001.isp.belgacom.be
	[195.238.3.51]) by ozlabs.org (Postfix) with ESMTP id 1E3AA679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Jun 2005 04:13:28 +1000 (EST)
Received: from outmx001.isp.belgacom.be (localhost [127.0.0.1])
	by outmx001.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j54IDOn0026053
	for <linuxppc-embedded@ozlabs.org>; Sat, 4 Jun 2005 20:13:24 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <42A1EF45.9030400@246tNt.com>
Date: Sat, 04 Jun 2005 20:13:25 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
References: <1116607235.29111.20.camel@gleep>	<f003613a0526b7b6a00a0bd477cd5ac3@freescale.com>
	<1117221259.26114.91.camel@cashmere.sps.mot.com>
In-Reply-To: <1117221259.26114.91.camel@cashmere.sps.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: bd_t Cleaning: Interface Part
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> On Thu, 2005-05-26 at 18:08, Kumar Gala wrote:
> 
>>Jon,
>>
>>Can you break the patch up into a few pieces, it will be easier to 
>>review that way.  Here are the following pieces that make sense to me:
>>
>>0. New firmware interface (fw_bdt*, Kconfig, ...)
>>1. board code changes (everything in arch/ppc/platforms/*)
>>2. driver changes (things in *_io, ide, net, serial dirs -- try to give 
>>a better list below)
>>3. System changes (files in arch/ppc/syslib and include/asm-ppc)

FWIW, tested on 5200 and works fine. Looks good to me.

Just a remark : I see a CONFIG_FW_OF option that activates
fw_of.o but there is no fw_of.c and I don't see what the flattened
OF tree does in this set of patch ?



	Sylvain
