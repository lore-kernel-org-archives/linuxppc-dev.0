Return-Path: <dean@bong.com.au>
Received: from mail.netspace.net.au (cumulus.netspace.net.au [203.10.110.72])
	by ozlabs.org (Postfix) with ESMTP id 98C692BF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Dec 2004 23:46:27 +1100 (EST)
Message-ID: <41CAB92A.4050808@bong.com.au>
Date: Thu, 23 Dec 2004 23:25:14 +1100
From: Dean Hamstead <dean@bong.com.au>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <Pine.LNX.4.21.0412230130510.5692-100000@hal.pp.fishpool.fi>	
	<41CA0E0D.908@bong.com.au> <1103788847.29975.10.camel@gaston>
In-Reply-To: <1103788847.29975.10.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] Fix Alsa issues including Oopses with OSS emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

given the variety of hardware would it be worth splitting up snd-powermac?

how easily can code be used from darwin?

Dean

Benjamin Herrenschmidt wrote:

>On Thu, 2004-12-23 at 11:15 +1100, Dean Hamstead wrote:
>  
>
>>the pmac driver has issues on my imac dv, it works but alas
>>it doesnt know what to do when plugging in headphones
>>not to mention lack of input sensors for my ibook (clamshell)
>>
>>i realise though that if you cant get specs and no one
>>wants to tinker around stuff wont get implemented.
>>but if its in OSS...
>>    
>>
>
>Well, there are specs: the Darwin sources are available for all of Apple
>sound drivers. It's just that there are approx. as many HW setups as
>motherboards, so it's a bit of a mess, and I don't have much time to dig
>into it (and I didn't write the Alsa driver).
>
>But others are welcome to work on it & propose patches :)
>
>Ben.
>
>
>
>  
>

-- 
WWW: http://dean.bong.com.au  LAN: http://www.bong.com.au
EMAIL: dean@bong.com.au       or       djzort@bong.com.au
ICQ: 16867613
