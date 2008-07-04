Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B35B2DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 17:53:14 +1000 (EST)
Message-ID: <486DD70E.9050503@grandegger.com>
Date: Fri, 04 Jul 2008 09:53:50 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] powerpc: add FHCI USB, FSL MCU, FSL UPM and GPIO LEDs
	bindings
References: <20080703174844.GA27966@polina.dev.rtsoft.ru>
In-Reply-To: <20080703174844.GA27966@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

Anton Vorontsov wrote:
> This patch adds few bindings for the new drivers to be submitted through
> the appropriate maintainers.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> Segher, thanks for the comments on the previous version. Do you see any
> issues with this one or anything I could improve further?
> 
> And if there are no issues... Kumar, could you apply this for powerpc-next?

As you know, I have some additions to your bindings and I posted a patch 
recently:

   http://ozlabs.org/pipermail/linuxppc-dev/2008-June/058617.html

Segher did not comment yet, maybe you would like to have a look. And do 
you have some news about the corresponding NAND support from the MTD people?

I really appreciate breaking booting-without-of.txt up. Will this happen 
already for powerpc-next (for 2.6.27)?

Thanks,

Wolfgang.
