Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 8136DDDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 03:28:03 +1100 (EST)
Message-ID: <47752412.7040708@pikatech.com>
Date: Fri, 28 Dec 2007 11:28:02 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: Problems with arch/powerpc
References: <47742519.8060502@pikatech.com>	<20071227194753.56bc92f8@vader.jdub.homelinux.org>	<477493D9.7070700@pikatech.com>	<47749548.8020908@pikatech.com>
	<20071228072512.01c6eba8@vader.jdub.homelinux.org>
In-Reply-To: <20071228072512.01c6eba8@vader.jdub.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> Does the setjmp call use floating point instructions?  I'm wondering if
> the APU isn't enabled for the FPU on the Yosemite board for some
> reason.  If that wasn't enabled, weird things would happen.
>   
That was it! The cputable did not have an entry for the 440EP Rev C! So 
the FPU flag was not being set.

Cheers,
    Sean
