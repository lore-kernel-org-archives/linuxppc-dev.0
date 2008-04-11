Return-Path: <tnt@246tnt.com>
Received: from mailrelay010.isp.belgacom.be (mailrelay010.isp.belgacom.be
	[195.238.6.177]) by ozlabs.org (Postfix) with ESMTP id 61A4FDE0E9
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 17:29:37 +1000 (EST)
Message-ID: <47FF135E.2060003@246tnt.com>
Date: Fri, 11 Apr 2008 09:29:34 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: State of the MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>
In-Reply-To: <47FDEF9B.5000506@semihalf.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: spitzauer_77@gmx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Last year you have posted a MPC5200 PSC AC97 driver patch
> "[PATCH 9/9] sound: Add support for Freescale MPC5200 AC97 interface."
> with the following comment:
>
>   
>> Not quite a clean driver, but it get things done (well, mostly).
>> Only included to be able to test functionalityi/usage of
>> the BestComm driver.
>>     
Yes ... and it still applies.
>
> There are various FIXMEs and commented out code here and there.
> Could you elaborate a bit on the overall state of the driver's
> functionality,
> which areas need improvement and attention?
>   
It's a minimum boiler plate.
I filled the function at the minimum to get some sound output and being
able to hear music coming out of it :)
I also completely skipped the 5200 (not B) support ...

At first there was no DMA at all (full software copy). I added some
simple DMA later just to prove it could work and how to use the API.

I just wrote it to get some sound, prove the interface could work under
linux and to show how to use DMA. I had hoped someone else would finish
it ... (yeah, I know ... big mistake).
> Seems that you mainly tested BestComm with this driver, what was the
> overall
> BestComm performance, any issues here? Did you use any specific test setup
> involving some dedicated application, etc.?
>   
My test was listening to Gorrillaz "Feel Good inc" using mplayer ...

> Did anyone else tried it and/or has a updated version or can share
> experience?
>   
At the time several other people tried it and it worked ... unless you
did lots of harddrive IO and then it crumbled ...



Sylvain
