Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0FE6F67B89
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 05:16:38 +1000 (EST)
In-Reply-To: <a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>
References: <44B7857A.2060101@freescale.com>
	<B8AB8BA6-500C-43AC-B6E7-A76CA598A429@kernel.crashing.org>
	<a0bc9bf80607140921y5d11bf37r3f18e2dbdd03b017@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A4F686A1-9558-4DD0-BF4C-BB64494BB719@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support
Date: Mon, 17 Jul 2006 14:16:42 -0500
To: Li Yang <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 14, 2006, at 11:21 AM, Li Yang wrote:

> On 7/14/06, Kumar Gala <galak@kernel.crashing.org> wrote:
>> Nack, my expectation is this is all setup by the boot loader.
>
> That's a good wish. ;)  However, USB is not required by bootloader. So
> it is not likely to be initialized there.  And if we put it in
> bootloader, it will be hard to change the mode(MPH/DR), which requires
> a re-burn of bootloader.  It's better that we make sure it's correctly
> configured here.

I disagree.  You are coming from this from a board that does  
everything under the sun.  I'd like to avoid having this type of  
initialization in the kernel.  There is a whole additional kitchen  
sink that could move into the kernel as well.

- kumar 
  
