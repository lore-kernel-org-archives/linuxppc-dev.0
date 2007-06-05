Return-Path: <gjalt007@chello.nl>
Received: from viefep20-int.chello.at (viefep18-int.chello.at [213.46.255.22])
	by ozlabs.org (Postfix) with ESMTP id EC6BCDDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jun 2007 17:44:55 +1000 (EST)
Message-ID: <46651027.2010906@chello.nl>
Date: Tue, 05 Jun 2007 09:26:31 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: RTC drift in PPC
References: <010001c792f4$a5d3dfb0$4601a8c0@signet>
	<46433008.5070508@BitWagon.com>
In-Reply-To: <46433008.5070508@BitWagon.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I 'v measured the clock on a mpc8280 board running the 2.4.25 kernel 
obtained from ELDK3.1.1, no problem with the clock during a test period 
of a few days.

Theo.
>> We are running RTC on mpc860 board with external crystal...
>> We are getting 4 minutes drift for 21 hours.
>>     
>
> A slowdown in the approx. range 1:300 to 1:350 is endemic to linux ppc:
> http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=157581
>
>   
