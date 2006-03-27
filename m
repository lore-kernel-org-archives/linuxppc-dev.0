Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1C66B67B6D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 00:52:02 +1100 (EST)
Received: from vitb.ru.mvista.com ([10.150.0.9])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id k2RDpws08431
	for <linuxppc-embedded@ozlabs.org>; Mon, 27 Mar 2006 18:51:58 +0500
Date: Mon, 27 Mar 2006 17:52:01 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Freescale MPC8xx USB support
Message-ID: <20060327175201.13e3c617@vitb.ru.mvista.com>
In-Reply-To: <4427E4BB.5090509@cs.fau.de>
References: <4427E4BB.5090509@cs.fau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 27 Mar 2006 15:12:27 +0200
Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de> wrote:

> Hello,
> 
> in the last linux stable release 2.6.15 i couldn't find any driver for 
> the USB-hostcontroller embedded in Freescale MPC875. Is there some work 
> ongoing or must i start writing my own driver ?
> 
No, there are no active projects covering it afaik. Some patches are
floating around 
http://www.heeltoe.com/software/usb/usb.html, but it should be reworked to 2.6, and there are no guarantee that it'll work after all...
> thanks in advance
> Josef
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
