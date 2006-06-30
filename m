Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 12CBC679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 03:32:54 +1000 (EST)
Message-ID: <44A560D1.9050509@ru.mvista.com>
Date: Fri, 30 Jun 2006 21:35:13 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Ming Liu <eemingliu@hotmail.com>
Subject: Re: Xilinx SystemACE driver for 2.6
References: <BAY110-F40223AFCCAA679FBC5A962B27D0@phx.gbl>
In-Reply-To: <BAY110-F40223AFCCAA679FBC5A962B27D0@phx.gbl>
Content-Type: text/plain; charset=GB2312
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

Ming Liu wrote:
>>> My linux version is 2.6.16-rc5.
>> I don't think there is any issue with your kernel version apart from the
>> fact that 2.6.16- series posed considerable problem for me when trying
>> to configure a serial shell. The serial driver is BUGGY. So I use
>> 2.6.17.1 (latest release).
> 
> I use this version only because I want to implement the Temac driver in the 
> link of 
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html It 
> looks that the patches are specific for that version. 

There is nothing special in the TEMAC driver that binds it to 2.6.16-rc5.
The patch was generated against and tested with that kernel version. That's all.
The patch will probably not apply cleanly to the more recent kernels. But
otherwise it should work.

In other words, feel free to use that TEMAC patch with the recent kernel.

Thanks,
Andrei
