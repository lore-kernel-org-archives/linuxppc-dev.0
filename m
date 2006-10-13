Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 025F467BFD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 17:23:01 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GYHNj-0002gl-2S
	for linuxppc-embedded@ozlabs.org; Fri, 13 Oct 2006 09:22:59 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<452F3A82.7070803@dlasys.net>
Date: Fri, 13 Oct 2006 09:22:59 +0200
In-Reply-To: <452F3A82.7070803@dlasys.net> (David H. Lynch, Jr.'s message of
	"Fri, 13 Oct 2006 03:04:34 -0400")
Message-ID: <871wpcvfvw.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David H Lynch <dhlii@dlasys.net> writes:

Hi,

David>     Nobody has given me a reason yet why the UartLite should
David> init different from the 8250, and absent a reason, I would
David> mimic the 8250. I do not think there is reason for a different
David> routing name.  The ml403 8250 init code deals with multiple
David> 8250's, I did the same with UartLite.

8250 is not the only serial driver. I think the reason why 8250 uses
it's own struct is simple that it's a really old driver. Newer drivers
like atmel_serial.c also uses the platform bus.

David>     I am not sure I did nto follow everything on linux-serial -
David> but I think Peter was asked to remove support for additional
David> uarts. I am not sure why.

Remove support? I don't remember anything about that.

-- 
Bye, Peter Korsgaard
