Return-Path: <matej.kupljen@ultra.si>
Received: from deliver-1.mx.triera.net (deliver-1.mx.triera.net [213.161.0.31])
	by ozlabs.org (Postfix) with ESMTP id A493067A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 08:21:42 +1100 (EST)
From: Matej Kupljen <matej.kupljen@ultra.si>
To: Sylvain Munaut <tnt@246tNt.com>
In-Reply-To: <4213B356.3060901@246tNt.com>
References: <1108547431.30212.37.camel@mbmatejdebian.ultra.si>
	<4213B356.3060901@246tNt.com>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 22:21:36 +0100
Message-Id: <1108588896.15304.7.camel@orionlinux.starfleet.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bdi2000 debugging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

> The good news : I can explain you BDI2000 problem :)

Thank you for the explanation. 

> The bad news : AFAIK you can't fix it :(
> 
> There is a bug in the rev <= 1.2 of the silicon of MPC5200 : When there
> is another XLB Master active (like USB or any bestcomm activity), the XLB
> arbiter can get confused during debugging and you can resume nor
> can you access memory or do anything ... you can just reboot.

Hmm, this is not good. :(
How can I determine the silicon rev.?
I'll look it up in the docs.

> It's VERY frustrating since the BDI2000 is then kind of useless for debug
> in the cases when you need those activated ...

So I have to disable USB (can live without it for debugging), bestcomm
(hmm, how can I use console on serial port then?) and what else?

Thanks again for the explanation, I'd spent one more week on this.
Now I know I have to use a different approach :-(

BR,
Matej
