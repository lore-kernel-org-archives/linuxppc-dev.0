Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7020067B6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 09:20:28 +1000 (EST)
Message-ID: <4509E2B5.2070202@dlasys.net>
Date: Thu, 14 Sep 2006 19:16:05 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Keith J Outwater <kjoutwater@raytheon.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
References: <OF1385C39A.BEB9B9E6-ON072571E9.005DAC98-072571E9.0060ABAE@mck.us.ray.com>
In-Reply-To: <OF1385C39A.BEB9B9E6-ON072571E9.005DAC98-072571E9.0060ABAE@mck.us.ray.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Keith J Outwater wrote:
>> Hi,
>
> I don't think that there are any "version" registers in the Xilinx 
> IP cores that a driver could check to determine compatibility.  That
> would be very cheap to implement in hardware and you could then
> develop more universal drivers.
>
>   
    Some of the IP's do, some don't - and then some might.
    Some of the documentation isn't too bad, some is almost un-uasable.
   
 
   




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
