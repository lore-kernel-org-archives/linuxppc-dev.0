Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B67E1DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 05:40:52 +1100 (EST)
Message-ID: <45E5C333.2060100@zytor.com>
Date: Wed, 28 Feb 2007 10:00:19 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
References: <45E46976.6060600@freescale.com>	<29c13109971547687159078eacdea008@kernel.crashing.org>	<45E592DC.9060700@freescale.com>	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>	<45E5B604.904@freescale.com>
	<46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
	<45E5BD6B.1010509@freescale.com>
	<F2D0230C-CA22-4DEF-917E-6982FA0C6171@embeddedalley.com>
	<45E5C128.7020204@freescale.com>
In-Reply-To: <45E5C128.7020204@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Torben.Mathiasen@hp.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Dan Malek wrote:
> 
>> I'd shoot that down, too.  Using udev in an
>> embedded, reliable environment is very
>> troublesome.  Although, products I've
>> developed using more than 4 UARTs had
>> some custom /dev work done to it just
>> to get everything mapped.  My only
>> concern is we don't add a new range for
>> QE UARTs, that we use the same minors
>> for both CPM and QE.
> 
> Then it appears that the only possible solution is to assign numbers 46 
> - 53 to the CPM/QE and accept that it overlaps with the Altix.  Is 
> everyone okay with that?
> 

I would much rather see these devices moved to a different minor range.

	-hpa
