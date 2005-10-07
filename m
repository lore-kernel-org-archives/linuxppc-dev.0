Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10C55683A9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Oct 2005 02:19:21 +1000 (EST)
Date: Fri, 7 Oct 2005 17:19:17 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>, linuxppc-embedded@ozlabs.org
Message-Id: <20051007171917.538355cc.ajz@cambridgebroadband.com>
In-Reply-To: <43469CCD.5010404@ru.mvista.com>
References: <20051007163735.31f48aeb.ajz@cambridgebroadband.com>
	<43469891.9080908@ru.mvista.com>
	<20051007165749.305c6bd3.ajz@cambridgebroadband.com>
	<43469CCD.5010404@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: Oops accessing BCSR on 8272ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > 
> It depends on which u-boot you're using and there I'm aware of
> issues when BCSR resides somewhere different... Try 0xF8000000.
> Don't you have btw
> 

Thanks Vitaly.  You were right.  In my u-boot - version 1.1.1 - it was
0xf8000000 not 0xf4500000.  I just modified BCSR_ADDR and that stopped
the oops.

Cheers,

Alex
