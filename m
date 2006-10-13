Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 675F167C85
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 17:15:44 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GYHGg-0002dq-Tm
	for linuxppc-embedded@ozlabs.org; Fri, 13 Oct 2006 09:15:42 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<452F36AE.6040205@dlasys.net>
Date: Fri, 13 Oct 2006 09:15:42 +0200
In-Reply-To: <452F36AE.6040205@dlasys.net> (David H. Lynch, Jr.'s message of
	"Fri, 13 Oct 2006 02:48:14 -0400")
Message-ID: <8764eovg81.fsf@sleipner.barco.com>
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

David>    Peter's driver uses the IORESOURCE requests to pull platform
David> data.  Most other serial platformdevices pull a uart_port
David> object.  My limited understanding of IORESOURCE is that it is
David> not sufficiently deep to support the parameters that are needed
David> to support UartLite such as a DCR flag and a regoffset.

I'm still not convinced that DCR access and variable register offsets
are needed - But it can always be added (through a seperate struct in
platform_data) - Patches are welcome.

The same with interrupt-less support if the changes are not too
intrusive.

David>    You are welcome to do that. I already patched his driver to
David> work with my early console support as well as adding the
David> boot-bash stuff similar to yours. But I gave up actually using
David> it when I could not get it to work.

Which is odd as I've gotten positive feedback from others.

David>    Next time I get an opportunity I am going to try to setup an
David> ml403 to atleast verify that Peter's driver is working there.

Great.

-- 
Bye, Peter Korsgaard
