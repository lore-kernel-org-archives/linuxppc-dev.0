Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C9883679EA
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 02:27:52 +1000 (EST)
To: "KRONSTORFER Horst" <Horst.KRONSTORFER@frequentis.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [QUESTION] MPC834x DMA Support 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Apr 2006 12:37:19 +0200."
	<C5BA91F04186584EB68FD42BB4993E6BC1B5C6@FRQWOLEX01.frequentis.frq>
Date: Thu, 27 Apr 2006 18:27:49 +0200
Sender: wd@denx.de
Message-Id: <20060427162749.B1984353DAC@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <C5BA91F04186584EB68FD42BB4993E6BC1B5C6@FRQWOLEX01.frequentis.frq> you wrote:
> 
> does anyone know if the mpc834x's dma unit supports dma operation
> only between pci and csb or also between csb and csb, f.e. devices
> connected via the lbc (f.e. ram and a dsp)?

This should work. We used this  to  initialize  ECC  memory.  But  be
careful  about your performance expectations - ask Freescale what you
can get out of memory to memory DMA. [Sorry, I'm  still  waiting  for
replies from FSL myself.]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You speak of courage. Obviously you do not know the  difference  bet-
ween  courage and foolhardiness. Always it is the brave ones who die,
the soldiers.
	-- Kor, the Klingon Commander, "Errand of Mercy",
	   stardate 3201.7
