Return-Path: <jengelh@linux01.gwdg.de>
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B2EEDDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 10:14:06 +1100 (EST)
Date: Wed, 28 Feb 2007 23:40:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
In-Reply-To: <ce5df0c760f6b5ab896b31d1ce2839ee@kernel.crashing.org>
Message-ID: <Pine.LNX.4.61.0702282339470.23355@yvahk01.tjqt.qr>
References: <45E46976.6060600@freescale.com>
	<29c13109971547687159078eacdea008@kernel.crashing.org>
	<45E592DC.9060700@freescale.com>
	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>
	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>
	<45E5B604.904@freescale.com>
	<46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
	<45E5BD6B.1010509@freescale.com>
	<F2D0230C-CA22-4DEF-917E-6982FA0C6171@embeddedalley.com>
	<45E5C128.7020204@freescale.com> <45E5C333.2060100@zytor.com>
	<ED6BD6F0-827F-4ADC-9D66-F9C3DD7FC470@embeddedalley.com>
	<ce5df0c760f6b5ab896b31d1ce2839ee@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Torben.Mathiasen@hp.com,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 28 2007 20:25, Segher Boessenkool wrote:
>> Just allocate the four slots and we'll deal with
>> anything above this in custom products.
>
> Another option is to use 46..49 for UARTs #0..3,
> and 192..195 for UARTs #4..7.
>
> Or, perhaps better, use 46..49 for #0..3, and
> 192..199 for #0..7, handling the duplication in
> the driver; and deprecate the old range.

I'd "vote" for the 2nd. 


Jan
-- 
