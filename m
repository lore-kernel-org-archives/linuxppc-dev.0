Return-Path: <wd@denx.de>
Received: from mailout09.sul.t-online.com (mailout09.sul.t-online.com
	[194.25.134.84]) by ozlabs.org (Postfix) with ESMTP id 1C4E068527
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 19:31:43 +1000 (EST)
To: "Alexey Dyatchkov" <alexey@waves.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Oct 2005 09:48:46 +0200."
	<002001c5ce38$3a5de690$0100000a@Omerxp>
Date: Tue, 11 Oct 2005 11:31:16 +0200
Sender: wd@denx.de
Message-Id: <20051011093116.85033353ADC@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8xx slave USB driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <002001c5ce38$3a5de690$0100000a@Omerxp> you wrote:
> I believe, it was taken from the development tree. Actually, I joined this
> project already after the linux was tuned for the board, it was about 3 or 4
> years ago.

Please make sure to specify exactly which source tree you are talking
about. There are too many different versions of 2.4 trees for PPC.

> > We are using slightly modified Denx linux 2.4.12 on our board (modified
> > RPXLITE)
> 
> We never released such a kernel version.

We (DENX) never released such a tree. We jumped from 2.4.4 to 2.4.18;
and we never removed anything from the development tree -  the  whole
history is on our CVS server (and now also on git).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
You don't have to worry about me. I might have been born yesterday...
but I stayed up all night.
