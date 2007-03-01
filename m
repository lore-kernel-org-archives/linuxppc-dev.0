Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id 800CADDF38
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 03:06:13 +1100 (EST)
In-Reply-To: <45E6F78A.7070603@freescale.com>
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
	<A6EED9FC-4CE4-4089-ACB8-A1C7A3C50FDD@embeddedalley.com>
	<a2fc3b0b25c4ad798b63b03763256a2f@kernel.crashing.org>
	<BE8D549F-71E4-43DE-B624-A8E4A50D094D@embeddedalley.com>
	<45E6F78A.7070603@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D077F753-DA34-47AD-8F8F-76643A0DD692@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
Date: Thu, 1 Mar 2007 11:06:12 -0500
To: Timur Tabi <timur@freescale.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Torben.Mathiasen@hp.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Since I'm probably the only one that
really uses the driver for custom
uses and cares......

On Mar 1, 2007, at 10:55 AM, Timur Tabi wrote:

> Ok guys, I need a consensus here.  Are we going to allocate a  
> second block of 4 minor numbers for the QE/CPM UART or not?

not.

> My driver already has a macro that limits the number of UARTS to 4,

perfect.

> I'll add a second TTY struct...

Don't worry about it for now.  We'll just keep this in
mind when we make a major change someday in
the future.  We may have a better solution then.

Thanks.

	-- Dan
