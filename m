Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71819DDE38
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 May 2007 16:39:24 +1000 (EST)
Received: from [206.223.20.140]
	by mx.dlasys.net with esmtp (Exim 4.63 #1 (Debian))
	id 1Hkwpf-0005Sw-8O
	for <linuxppc-embedded@ozlabs.org>; Mon, 07 May 2007 02:36:27 -0400
Message-ID: <463EC955.4060808@dlasys.net>
Date: Mon, 07 May 2007 02:38:13 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: virtex_devices.c
References: <463C379D.7020804@dlasys.net>
	<528646bc0705051516h2b0259cfgbe3be784acf4086a@mail.gmail.com>
	<463E4B13.2030600@dlasys.net>
	<528646bc0705061746s28ebb15et428c7afda2f477ba@mail.gmail.com>
	<528646bc0705061817h7a8fd767v73195e9d4572b8e1@mail.gmail.com>
In-Reply-To: <528646bc0705061817h7a8fd767v73195e9d4572b8e1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
>
> Although this point is actually moot because platform_bus pretty much
> goes away when we move to arch/powerpc.  We'll be using
> of_platform_devices instead (which map onto nodes in the device tree).
    That I got and as I pound away at all of this I keep thinking my
time would be better spent figuring out device trees.
   

>


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
