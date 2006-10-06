Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D9FA67E9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Oct 2006 18:53:52 +1000 (EST)
Message-ID: <452618E5.3080200@dlasys.net>
Date: Fri, 06 Oct 2006 04:50:45 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: booting 2.6 kernel on ML403
References: <BAY110-F79748D36D754E6D6B2A99B21D0@phx.gbl>
In-Reply-To: <BAY110-F79748D36D754E6D6B2A99B21D0@phx.gbl>
Content-Type: text/plain; charset=GB2312
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ming Liu wrote:
> Hello Ameet,
> I am using that driver very well now. There is only one problem. It
> seems that the driver for TEMAC only support Gigabit Enet, not
> 10/100/1000M adapted. But because I want to use the Gigabit enet, I
> don't care that. So it's OK, at lease for 1Gbit/s.
It is fairly easy to mangle the TEMAC driver for any fixed rate you
want. I added a spd value to the device data, set it to whatever I want
in the initcode, and
changed the SetSpeed () call to use the device data value instead of a
constant.
That was a 2 min kludge. At some point it needs real autonegotiation -
which should not be too hard.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
