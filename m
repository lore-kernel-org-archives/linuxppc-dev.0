Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id BEEC2688D9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 21:09:49 +1100 (EST)
Message-ID: <43A686EA.5040304@ru.mvista.com>
Date: Mon, 19 Dec 2005 13:09:46 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: "David H. Lynch Jr." <dhlii@comcast.net>
References: <OF22452781.22D7B3D3-ON652570D9.0019E468-652570D9.001A1298@tcs.com>
	<43A64446.8080109@comcast.net>
In-Reply-To: <43A64446.8080109@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>, linuxppc-embedded@ozlabs.org
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
Yes, this is the right place.
> 	Is there a HOWTO addressing the rules/procedures to do so.
> 
Dunno actually, but that is not that tricky. Just send patches here, splitted if 
possible to understand better what each one does, don't forget detailed description of a change 
and the Signed-off-by: line. 
> 	I have not looked at the kernel style guides, but the style of this
> code is pretty much identical to other Kernel code. The UartLite driver
> is virtually indistinguishable from other driver/serial drivers except
> the few places where hardware differences require changes, and that
> there is a full tree of end-end support similar to what exists for the
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
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
