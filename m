Return-Path: <dan@embeddedalley.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id CC4CEDDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 07:57:50 +1100 (EST)
In-Reply-To: <45E5DB49.8010205@freescale.com>
References: <45E46976.6060600@freescale.com>	<29c13109971547687159078eacdea008@kernel.crashing.org>	<45E592DC.9060700@freescale.com>	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>	<45E5B604.904@freescale.com>
	<46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
	<45E5BD6B.1010509@freescale.com>
	<F2D0230C-CA22-4DEF-917E-6982FA0C6171@embeddedalley.com>
	<45E5C128.7020204@freescale.com> <45E5C333.2060100@zytor.com>
	<ED6BD6F0-827F-4ADC-9D66-F9C3DD7FC470@embeddedalley.com>
	<E919B903-0890-4725-81CF-005003A1A2F6@kernel.crashing.org>
	<45E5D627.6030707@zytor.com> <45E5D84A.5000502@freescale.com>
	<278AADB6-E175-4177-A728-5357E21697B7@kernel.crashing.org>
	<45E5DB49.8010205@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6EED9FC-4CE4-4089-ACB8-A1C7A3C50FDD@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
Date: Wed, 28 Feb 2007 15:57:48 -0500
To: Timur Tabi <timur@freescale.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>, Torben.Mathiasen@hp.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 28, 2007, at 2:43 PM, Timur Tabi wrote:

> What about major number 205?  It also has the screwed-up /dev/ 
> ttyCPM entries, but it has more room, and the CPM driver doesn't  
> actually use it.  At least, I can't see where it uses it.

Please, let's just leave the four we have and let
the driver just allocate increasing minor numbers.
If anyone has a product with more than 4 UARTs,
they will have to figure out what to do with the
additional minors.

We are making a very complicated problem
out of nothing.  This hasn't caused any problems
in the past, and changing the existing names and
minors will cause problems for everyone today.

Just leave it alone, fix up the documentation,
and have the driver print some warning if it
allocates more than 4 UARTs.

Thanks.

	-- Dan
