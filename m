Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DFA4B68778
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jan 2006 19:23:07 +1100 (EST)
To: "Jonathan Qiang" <jonathan@haliplex.com.au>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Jan 2006 14:06:18 +1100."
	<32A7B31E4005134E8BA805EBAAFB9DCD9C7A1C@hellskitchen.haliplex.com.au>
Date: Tue, 10 Jan 2006 09:23:04 +0100
Sender: wd@denx.de
Message-Id: <20060110082304.019AA352B1E@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [Problem] linux 2.6.14 kernel hang up after the uImage
	uncompressed successfully
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <32A7B31E4005134E8BA805EBAAFB9DCD9C7A1C@hellskitchen.haliplex.com.au> you wrote:
> 
> I am doing booting linux kernel 2.6.14.5 from kernel.org on a kind of
> embedded ppc board, where the chip mpc8272 has been settled.
> But  after u-boot(1.1.4) finished booting itself and uncompressed the
> uImage(2.6.14.5 based). the kernel can not boot
> Successfully. It stop somewhere. the script is below: 

Read a FAQ: http://www.denx.de/wiki/view/DULG/FaqLinux

Try a port mortem dump of the log buffer area.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"A fractal is by definition a set for which the Hausdorff Besicovitch
dimension strictly exceeds the topological dimension."
- Mandelbrot, _The Fractal Geometry of Nature_
