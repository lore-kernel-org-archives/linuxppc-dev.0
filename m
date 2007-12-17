Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D484BDDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Dec 2007 05:40:18 +1100 (EST)
Date: Mon, 17 Dec 2007 21:33:41 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Misbah khan <misbah_khan@engineer.com>
Subject: Re: USB configuration
Message-ID: <20071217213341.630cbdf5@kernel.crashing.org>
In-Reply-To: <14192347.post@talk.nabble.com>
References: <14192347.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Vitaly Bordug <vbordug@ru.mvista.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 6 Dec 2007 05:27:14 -0800 (PST)
Misbah khan wrote:

> 
> HI all ...
> I have configured the Montavista Kernel for USB support and for
> PPC8272-ADS board I need to know that how could i test that my USB is
> working ????
> 

I'm not sure what MV version you are trying to use, but there is no support for USB host(I am about 8272ads).
MV supports USB gadget though...
> Its creating the directory :- /proc/bus/usb/ but doesent contain any
> file under it ????
> 
you enabled generic usb support. But no HW/driver picking it up
> 
> its also creating the directory :- /sys/bus/usb/   but doesent
> contain any file under it ????
> 
same reason
> 
> Please let me know the procedure to test whether my USB configuration
> is all right ????
> 
First, if you want to use USB host, you'll have to develop the driver first or assist someone doing that (there yet another such attempt recently initiated - see linuxppc-dev logs)

> Thank u 
> Misbah <><


-- 
Sincerely, Vitaly
