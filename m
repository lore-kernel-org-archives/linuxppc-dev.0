Return-Path: <greg.weeks@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 88DF567A64
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2005 23:53:18 +1000 (EST)
Message-ID: <4253E9CB.20009@timesys.com>
Date: Wed, 06 Apr 2005 09:53:15 -0400
From: Greg Weeks <greg.weeks@timesys.com>
MIME-Version: 1.0
To: David Frascone <dave@frascone.com>
References: <20050406081201.07b9bdce@greenlantern.frascone.com>
In-Reply-To: <20050406081201.07b9bdce@greenlantern.frascone.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Bogomips?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Frascone wrote:

>Can this be right?  I'm getting This from a MPC-8260 (/proc/cpuinfo):
>
>------------------------------------------------
>cpu             : 82xx
>core clock      : 199 MHz
>CPM  clock      : 133 MHz
>bus  clock      : 33 MHz
>revision        : 1.1 (pvr 0081 0101)
>bogomips        : 133.12
>------------------------------------------------
>
>And this from a MPC-8540
>------------------------------------------------
>cpu             : e500
>revision        : 2.0 (pvr 8020 0020)
>bogomips        : 190.05
>Vendor          : Motorola SPS
>Machine         : mpc8540ads
>bus freq        : 666.666660 MHz
>PVR             : 0x80200020
>SVR             : 0x80300020
>PLL setting     : 0x4
>Memory          : 512 MB
>------------------------------------------------
>
>
>The second one looks way low . . . any ideas?
>  
>
Do you have cache turned on? Do you have branch prediction turned on? 
Branch prediction would be my guess as it's easy to miss.

Greg Weeks
