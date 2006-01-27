Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 12CC068A20
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 21:54:43 +1100 (EST)
Date: Fri, 27 Jan 2006 15:43:23 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Jonathan Qiang" <jonathan@haliplex.com.au>
Subject: Re: Question on  USB gadget device driver for mpc 8272 on linux
	2.6.14.
Message-ID: <20060127154323.40e9404e@vitb.ru.mvista.com>
In-Reply-To: <32A7B31E4005134E8BA805EBAAFB9DCD9C7A20@hellskitchen.haliplex.com.au>
References: <32A7B31E4005134E8BA805EBAAFB9DCD9C7A20@hellskitchen.haliplex.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jonathan,

I have implemented the PQ2 usb-serial functionality a while ago, but the code needs a lot of cleanup, which is sometimes very tricky due to the tight timings required by this device. If you are interested, I can try to find the patch...

On Fri, 27 Jan 2006 11:45:39 +1100
"Jonathan Qiang" <jonathan@haliplex.com.au> wrote:

> Hi, all
>  
> Currently, I am doing on the USB gadget device driver for mpc8272, I
> already got some packets on interruption route when my board in which
> mpc82xx settled connect to Host.
> But the SOF is always generated as the first interruption source. When
> plugged USB cable in HOST, the USB controller will be set to reset
> (USBER is [0x308]), and after reset, the interruption source event
> changes its status to [0x108], which means running on IDLE and SOF.  Why
> It is not IN token?
> I already disabled Frame timer when I probe the USB gadget controller. 


-- 
Sincerely, 
Vitaly
