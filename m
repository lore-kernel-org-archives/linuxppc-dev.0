Return-Path: <michal.simek@petalogix.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8E21BB7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 20 Aug 2009 19:34:35 +1000 (EST)
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220]) by ozlabs.org (Postfix) with ESMTP id B889BDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 19:34:33 +1000 (EST)
Received: by bwz20 with SMTP id 20so5678554bwz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 02:34:31 -0700 (PDT)
Message-ID: <4A8D1750.4000804@petalogix.com>
Date: Thu, 20 Aug 2009 11:28:48 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [V2] net: add Xilinx emac lite device driver
References: <20090819122920.37EE21728051@mail110-dub.bigfish.com>
	<20090820.022536.264747725.davem@davemloft.net>
In-Reply-To: <20090820.022536.264747725.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sadanan@xilinx.com, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	jgarzik@pobox.com, john.linn@xilinx.com, john.williams@petalogix.com
Reply-To: michal.simek@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Miller wrote:
> From: John Linn <john.linn@xilinx.com>
> Date: Wed, 19 Aug 2009 06:29:11 -0600
>
>   
>> This patch adds support for the Xilinx Ethernet Lite device.  The
>> soft logic core from Xilinx is typically used on Virtex and Spartan
>> designs attached to either a PowerPC or a Microblaze processor.
>>
>> Signed-off-by: Sadanand M <sadanan@xilinx.com>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
>>     
>
> Looks good, applied to net-next-2.6, thanks!
>   
There were one bug with spinlock which John L fixed but not send to
mainling list. :-(
He wanted to create new v3 version. :-(.
When he wake up, he send you that bug fix or v3 version with it.

Regards,
Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
