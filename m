Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-29.bluehost.com (outbound-mail-29.bluehost.com
	[67.138.240.211]) by ozlabs.org (Postfix) with SMTP id 62EA06895C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 31 Dec 2005 15:09:25 +1100 (EST)
Message-ID: <43B602BB.7030906@secretlab.ca>
Date: Fri, 30 Dec 2005 21:02:03 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@comcast.net>
References: <OF22452781.22D7B3D3-ON652570D9.0019E468-652570D9.001A1298@tcs.com>
	<43A64446.8080109@comcast.net>
In-Reply-To: <43A64446.8080109@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
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

David H. Lynch Jr. wrote:
> 	I am just polishing off bringup a Xilinx Virtex IV/ppc405 system with
> minimal hardware under 2.6.14.4.
> 	I have a collection of patches that I can submit for the specific,
> board, for the Virtex IV, for board specific hardware, ...
> 	Additionally I have 2 complete boot loader through full serial driver
> implementations of a pseudo serial console driver for this board when it
> is in a HOST development system - it is a compact flash card normally
> plugged into a PC during development and using the PC as the console,
> and a complete serial driver chain for the Xilinx UartLite as a console
> when not in a Host, or as a general serial driver. The Xilinx Driver is
> based heavily on other 2.6 driver/serial drivers and not the 2.4
> implementation from Xilinx.
> 
> 	Is this list the right place to submit this ?
> 	Is there a HOWTO addressing the rules/procedures to do so.
Do you want to send me your patches for the UartLite (and cc the list)?
 I'd be happy to take a look.  What other things did you change?

g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
