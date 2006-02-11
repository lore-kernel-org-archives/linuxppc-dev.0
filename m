Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6DFF467A58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 11:06:38 +1100 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: kernel startup 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 10 Feb 2006 17:32:13 CST."
	<Pine.LNX.4.44.0602101730210.31619-100000@gate.crashing.org>
Date: Sat, 11 Feb 2006 01:06:36 +0100
Sender: wd@denx.de
Message-Id: <20060211000636.E2C943535F1@atlas.denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.44.0602101730210.31619-100000@gate.crashing.org> you wrote:
> 
> > What does it mean that the load address is 0x00000000? 
> 
> its the address u-boot's going to jump to and start executing kernel code 
> from.

No. U-Boot will load (copy) the image to the load address  but  start
executing  kernel  code  at  the  entry  point  address  which may be
different.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Am besten betrachten Sie Fehlermeldungen als eine  Art  Psycho-Test,
mit  dem  herausgefunden  werden soll, wie belastbar Sie sind."
 - Dr. R. Wonneberger, Kompaktführer LaTeX, Kap. 1.6: Fehlermeldungen
