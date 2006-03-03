Return-Path: <nreddy@netenrich.com>
Received: from mail.netenrich.com (mail.netenrich.com [204.13.82.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC528679E0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Mar 2006 15:41:54 +1100 (EST)
Message-ID: <2611.61.95.208.2.1141362572.squirrel@61.95.208.2>
In-Reply-To: <190edfbd0603021801g5505cab9h8e285fdc7bf476d1@mail.gmail.com>
References: <190edfbd0603021801g5505cab9h8e285fdc7bf476d1@mail.gmail.com>
Date: Thu, 2 Mar 2006 21:09:32 -0800 (PST)
Subject: Re: Linux on PPC
From: nreddy@netenrich.com
To: "rtos" <rtos123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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

You can easily migrate to linux environment.

 1. You can use u-boot as a boot loader.
 2. You can choose any standard linux kernel but you may have to do some
R&D on it to port to your board.
 Insted you can buy Montavista Linux, so that you can get support also.

 And also there are many mailing lists where yo ucan get tremendous help
on linux.


Thanks,
Nagi



> Hi,
>
> We have a customized board running on IBM PPC 750. The customer boot
> loader
> is provided by the vendor.
> Also, the vendor has provided the BSP on vxworks.
>
> We are planning to use linux on this processor. What are the steps
> involved
> in booting the board with linux.
> Which linux to be used and what are the procedures involved. I dint come
> across a documents which had these details.
>
> I am new to the linux front. So any help is highly appreciated.
>
> thanks
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
