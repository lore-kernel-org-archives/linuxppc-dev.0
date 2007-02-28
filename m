Return-Path: <dan@embeddedalley.com>
Received: from smtp106.biz.mail.re2.yahoo.com (smtp106.biz.mail.re2.yahoo.com
	[206.190.52.175]) by ozlabs.org (Postfix) with SMTP id 75614DDE48
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 05:20:10 +1100 (EST)
In-Reply-To: <45E5C333.2060100@zytor.com>
References: <45E46976.6060600@freescale.com>	<29c13109971547687159078eacdea008@kernel.crashing.org>	<45E592DC.9060700@freescale.com>	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>	<45E5B604.904@freescale.com>
	<46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
	<45E5BD6B.1010509@freescale.com>
	<F2D0230C-CA22-4DEF-917E-6982FA0C6171@embeddedalley.com>
	<45E5C128.7020204@freescale.com> <45E5C333.2060100@zytor.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ED6BD6F0-827F-4ADC-9D66-F9C3DD7FC470@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
Date: Wed, 28 Feb 2007 13:20:07 -0500
To: H. Peter Anvin <hpa@zytor.com>
Cc: Torben.Mathiasen@hp.com, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Timur Tabi <timur@freescale.com>,
	Segher Boessenkool <segher@kernel.crashing.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 28, 2007, at 1:00 PM, H. Peter Anvin wrote:

> I would much rather see these devices moved to a different minor  
> range.

No.  We just did that all too recently, and
i don't know why the minors didn't get
allocated properly.  I don't want to have to
update all of our embedded software distributions
just because someone doesn't like minor
numbers that aren't causing trouble.
If we allocate unique spaces for all of the
possible UART variations, there isn't going
to be enough space.

Just allocate the four slots and we'll deal with
anything above this in custom products.  Using
more than four of these processor resources
as UARTs isn't likely to happen because there
won't be anything left for the interesting
communication ports.

Thanks.

	-- Dan
