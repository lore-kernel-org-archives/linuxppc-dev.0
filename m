Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-cn0ut-5.online-age.net (ext-cn0ut-5.online-age.net
	[63.210.253.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-cn0ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EB3EBDE1D9
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 00:17:16 +1100 (EST)
Received: from int-cn0ut-4.online-age.net (int-cn0ut-4.online-age.net
	[3.159.252.73])
	by ext-cn0ut-5.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n0UDHDmB006866
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:17:13 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-cn0ut-4.online-age.net
	[3.159.252.73])
	by int-cn0ut-4.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n0UDHC1c002728
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 08:17:12 -0500
Message-ID: <4982FDD0.7000409@gefanuc.com>
Date: Fri, 30 Jan 2009 13:17:04 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
References: <4982F311.4050507@gefanuc.com>
In-Reply-To: <4982F311.4050507@gefanuc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Martyn Welch wrote:
> Hi Guys,
> 
> It seems that 2.6.29-rc3 is not booting on the MPC8641 HPCN. I have just 
> updated u-boot to the latest git to see if that improved matters, 
> however I get stuck at the following. Any ideas?
> 

Gah! That lost it's formatting some how, sorry.

I have just tried 2.6.29-rc2 and I get the same.

Martyn


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
