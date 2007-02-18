Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.s-s-l.net",
	Issuer "Equifax Secure Global eBusiness CA-1" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D812ADDE24
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 18 Feb 2007 21:20:50 +1100 (EST)
Message-ID: <45D8286B.4030900@lkmail.de>
Date: Sun, 18 Feb 2007 11:20:27 +0100
From: Lorenz Kolb <linuxppcemb@lkmail.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Re: What is the difference between Montavista Kernel Source,
	and Kernel.Org Source
References: <mailman.1.1171760401.17466.linuxppc-embedded@ozlabs.org>
In-Reply-To: <mailman.1.1171760401.17466.linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


>> I'm Going to use linux on ML403.
>>
>> I want to know, what is the difference between the linux kernel source,
>> that we download from source.mvista.com ( using git ) and the original
>> kernel source code that we download from kernel.org?
>>     
>
> The multiple git trees hosted at source.mvista.com/git are development
> trees similar to the trees hosted at www.kernel.org/git.  Contact the
> individual developers for details on each tree.
>
> Dale Farnsworth
>
>   
Oh, and I thought that development does mean something like progress.
If I'd "develop" something "new" with last change 8 months ago, I guess 
my boss would not pay for that "development".

So what is the difference between kernel.org and montavista's tree for 
ML403.

kernel.org is quite a bit ahead.

Personally I'd recommend Denk's 2.6.19 tree (that's a 2.6.19 from 
kernel.org with some ppc specific patches, afaik) and patching the EDK 
8.2 into it. That's quite a lot of work (I am just doing that at the 
moment) but that's the only way to get an up-to-date system.
Currently my partner and I are working on building a minimalistic sound 
driver and in some future release a ALSA compliant sound driver and a 
new controller (with at least DMA support) as this is can still not be 
found in MontaVista.

Lorenz Kolb
