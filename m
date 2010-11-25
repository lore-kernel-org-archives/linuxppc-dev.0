Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id CBF6DB70AF
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Nov 2010 01:01:30 +1100 (EST)
Received: by fxm11 with SMTP id 11so995402fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Nov 2010 06:01:28 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1290692075.689.20.camel@concordia>
References: <1290607413.12457.44.camel@concordia>
	<1290692075.689.20.camel@concordia>
Date: Thu, 25 Nov 2010 15:01:27 +0100
Message-ID: <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=UTF-8
Cc: linux-arch <linux-arch@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 25, 2010 at 14:34, Michael Ellerman <michael@ellerman.id.au> wr=
ote:
> I've left for_each_child_of_node(), because I read it as "of", but maybe
> it's "OF"?

I always read it as "for each child-OF-node", so I would rename it to
"dt_for_each_child_node".

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
