Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-4.online-age.net (ext-cn0ut-4.online-age.net
	[63.210.253.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 30D91DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 20:37:16 +1100 (EST)
Received: from int-cn0ut-3.online-age.net (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by ext-cn0ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n129bDVB025748
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Feb 2009 04:37:13 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-3.online-age.net
	[3.159.252.72])
	by int-cn0ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n129b8Xa020256
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Feb 2009 04:37:12 -0500
Message-ID: <4986BEB9.3030606@gefanuc.com>
Date: Mon, 02 Feb 2009 09:36:57 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
References: <4982F311.4050507@gefanuc.com>
	<F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>
	<9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>
In-Reply-To: <9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
> 
> On Jan 30, 2009, at 8:42 AM, Kumar Gala wrote:
> 
>>
>> On Jan 30, 2009, at 6:31 AM, Martyn Welch wrote:
>>
>>> Hi Guys,
>>>
>>> It seems that 2.6.29-rc3 is not booting on the MPC8641 HPCN. I have 
>>> just updated u-boot to the latest git to see if that improved 
>>> matters, however I get stuck at the following. Any ideas?
>>
>> did you update your .dtb as well?

Yup, just double checked it. SOC mapped at ffe00000. If I use the wrong DTB I don't get any serial output...

> 
> We've changed the memory map for that board in the latest u-boot, which 
> is why you need a new .dtb.  If this still failing, let me know, and 
> I'll give it a try on my board and see what's up since this is probably 
> my fault :)
> 

It appears the same problem is affecting our sbc610 as well, the location of the SOC hasn't changed on that board.

Martyn


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
