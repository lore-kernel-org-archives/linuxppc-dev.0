Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.mud.yahoo.com (smtp107.biz.mail.mud.yahoo.com
	[68.142.200.255]) by ozlabs.org (Postfix) with SMTP id 28916DE01C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Jan 2007 09:38:39 +1100 (EST)
In-Reply-To: <35786B99AB3FDC45A821572461791973B1E2FE@gbrwgceumf01.eu.xerox.net>
References: <35786B99AB3FDC45A821572461791973B1E2FE@gbrwgceumf01.eu.xerox.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6AF3F0CB-B947-4C80-BE8F-2DFCA73172B3@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: JTAG emulator for MPC8548E (v2) 
Date: Thu, 25 Jan 2007 14:31:59 -0800
To: "Ramirez-Ortiz, Jorge" <Jorge.Ramirez-Ortiz@xerox.com>
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 25, 2007, at 1:56 PM, Ramirez-Ortiz, Jorge wrote:

> We are currently using two BDI-2000s to debug 2.6.18 kernels on the  
> ppc8545 rev(2) devices with no problems reported so far (apart from  
> a minor patch required in the kernel to set up breakpoints).

I'm working on a proper patch to add all of this
formally to the sources.  It's been irritating me for
a long time, so I'm reworking some of these jtag
debugger options.  Unfortunately, it touches more
than just 85xx to get it right.

Thanks.

	-- Dan
