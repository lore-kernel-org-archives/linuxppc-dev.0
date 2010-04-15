Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47985B7D08
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Apr 2010 06:05:27 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3FK59ML007245
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Apr 2010 13:05:19 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3FKD94L005691
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Apr 2010 15:13:09 -0500 (CDT)
Message-ID: <4BC77174.1020305@freescale.com>
Date: Thu, 15 Apr 2010 15:05:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: Add hibernation support for FSL
	BookE	processors
References: <20100224213802.GA12843@oksana.dev.rtsoft.ru>	<20100415184513.GA27101@oksana.dev.rtsoft.ru>
	<2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
In-Reply-To: <2954FCF7-F34C-4E9D-A2EB-AC117D287EB5@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Apr 15, 2010, at 1:45 PM, Anton Vorontsov wrote:
>> Kumar,
>>
>> According to patchwork, this is now delegated to you. Do you
>> have any objections to merge this?
> 
> Would like Scott's Ack.

I think we need to save IACn, DACn, DBCRn, PID0, and USPRG0.

Might want to also save TLB1 contents, and maybe things like HIDn, cache 
registers, etc. -- I don't think they're changeable post-boot currently, 
but it'd be good to avoid surprises if that were to change.

Otherwise ACK.

-Scott
