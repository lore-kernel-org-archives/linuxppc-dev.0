Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 0A7A9DDE44
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 02:06:25 +1000 (EST)
Message-ID: <4623A002.7080509@ru.mvista.com>
Date: Mon, 16 Apr 2007 20:10:42 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Mr Grant Likely's New Patches for 2.6 Kernel and Xilinx FPGA
	(	Virtex-4 & Virtex-2
References: <BAY115-W1269AFE45FDEDFDEB86A99B2530@phx.gbl>
	<528646bc0704150727p1583132ck5455a36782e4dbcc@mail.gmail.com>
In-Reply-To: <528646bc0704150727p1583132ck5455a36782e4dbcc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux PPC <linuxppc-embedded@ozlabs.org>,
	Mohammad Sadegh Sadri <mamsadegh@hotmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

Grant Likely wrote:
> On 4/15/07, Mohammad Sadegh Sadri <mamsadegh@hotmail.com> wrote:
>> - Do we still new to apply the paulus patch to the main kernel so that we can have hard TEMAC support? Or you have a same program as sys ace for it?
> 
> No, I did not include TEMAC support.  However, I will publish my git
> tree tomorrow which will include the TEMAC driver.


Seems the TEMAC driver is not on your git server yet. Hence the questions.

What IP versions is your TEMAC driver for?
Guess this is PLB TEMAC version 3.00a as you wrote auto negotiation is supported.

Is your driver based on the one by Xilinx (the one from EDK 8.2.02 and the update posted by Rick Moleres)?
Or is it something written from scratch?
Does it use the "level 1" (OS independent) code from EDK?

Does it support SGDMA, or FIFO mode, or both?
Checksum offloading?


Thanks,
Andrei
