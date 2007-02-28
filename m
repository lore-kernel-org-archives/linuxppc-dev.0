Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [192.83.249.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22D5CDDE38
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 06:21:28 +1100 (EST)
Message-ID: <45E5D627.6030707@zytor.com>
Date: Wed, 28 Feb 2007 11:21:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
References: <45E46976.6060600@freescale.com>	<29c13109971547687159078eacdea008@kernel.crashing.org>	<45E592DC.9060700@freescale.com>	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>	<45E5B604.904@freescale.com>
	<46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
	<45E5BD6B.1010509@freescale.com>
	<F2D0230C-CA22-4DEF-917E-6982FA0C6171@embeddedalley.com>
	<45E5C128.7020204@freescale.com> <45E5C333.2060100@zytor.com>
	<ED6BD6F0-827F-4ADC-9D66-F9C3DD7FC470@embeddedalley.com>
	<E919B903-0890-4725-81CF-005003A1A2F6@kernel.crashing.org>
In-Reply-To: <E919B903-0890-4725-81CF-005003A1A2F6@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Torben.Mathiasen@hp.com, Timur Tabi <timur@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> Why don't we allocate the 2nd group of four as well, just at a new 
> location.  They'll be discontinuous, but at least we'll have support for 
> all 8.
> 

Right, it means two tty driver structures, but that's not a problem.

	-hpa
