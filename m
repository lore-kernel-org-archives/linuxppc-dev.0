Return-Path: <carlsj@yahoo.com>
Received: from web34208.mail.mud.yahoo.com (web34208.mail.mud.yahoo.com
	[66.163.178.123]) by ozlabs.org (Postfix) with SMTP id F315868902
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Dec 2005 00:17:26 +1100 (EST)
Message-ID: <20051219131046.1171.qmail@web34208.mail.mud.yahoo.com>
Date: Mon, 19 Dec 2005 05:10:46 -0800 (PST)
From: John Carlson <carlsj@yahoo.com>
To: "David H. Lynch Jr." <dhlii@comcast.net>, linuxppc-embedded@ozlabs.org
In-Reply-To: <43A64446.8080109@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Re: Howto submit drivers/patches ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--- "David H. Lynch Jr." <dhlii@comcast.net> wrote:

> 
> 	I am just polishing off bringup a Xilinx Virtex
> IV/ppc405 system with
> minimal hardware under 2.6.14.4.
> 	I have a collection of patches that I can submit
> for the specific,
> board, for the Virtex IV, for board specific
> hardware, ...
> 	Additionally I have 2 complete boot loader through
> full serial driver
> implementations of a pseudo serial console driver
> for this board when it
> is in a HOST development system - it is a compact
> flash card normally
> plugged into a PC during development and using the
> PC as the console,
> and a complete serial driver chain for the Xilinx
> UartLite as a console
> when not in a Host, or as a general serial driver.
> The Xilinx Driver is
> based heavily on other 2.6 driver/serial drivers and
> not the 2.4
> implementation from Xilinx.
> 
> 	Is this list the right place to submit this ?
> 	Is there a HOWTO addressing the rules/procedures to
> do so.

Look in the Documentation directory, specificly the
two files
SubmittingDrivers and SubmittingPatches where the
correct
procedure is explained.

> 
> 	I have not looked at the kernel style guides, but
> the style of this
> code is pretty much identical to other Kernel code.
> The UartLite driver
> is virtually indistinguishable from other
> driver/serial drivers except
> the few places where hardware differences require
> changes, and that
> there is a full tree of end-end support similar to
> what exists for the
> 8250's.
> 
> David H. Lynch Jr.
> DLA Systems
> 354 Rudy Dam Rd.
> Lititz, PA 17543
> 717.627.3770
> 
> 
> 
> 
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
>
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 


John Carlson
<carlsj@yahoo.com>

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
