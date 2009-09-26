Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214]) by ozlabs.org (Postfix) with ESMTP id 17BD0B7BCF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Sep 2009 04:15:17 +1000 (EST)
Received: by fxm10 with SMTP id 10so2929866fxm.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 11:15:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0046254A-432D-4AE3-9B9F-C0D30311B7D7@codex.gr>
References: <0046254A-432D-4AE3-9B9F-C0D30311B7D7@codex.gr>
Date: Sat, 26 Sep 2009 20:15:14 +0200
Message-ID: <c384c5ea0909261115t361e019auadf3b76a312ff2d1@mail.gmail.com>
Subject: Re: Market research for new PowerPC system
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Konstantinos Margaritis <markos@codex.gr>
Content-Type: text/plain; charset=ISO-8859-1
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.ozlabs.org,
	opensuse-ppc@opensuse.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

first off, I like your idea. This is my public reply, I'll give a
personal reply later.

On Sat, Sep 26, 2009 at 1:38 PM, Konstantinos Margaritis
<markos@codex.gr> wrote:
> I'm considering funding the design & production of a new PowerPC system
> (well, the motherboard, the rest are typical pc stuff and a case). No this
>
What makes the system stand out, from say a Atom based PC?

(I know, playing devil's advocate here)

> 1. MPC8640D-based. It will be dual core at 1Ghz -most likely, higher
> frequencies are much more expensive and the cost of the final board would be
> prohibitive.
> 2. MPC8610-based. Single core at 1Ghz, slightly less expensive, and includes
> a 2D DIU display unit -quite fast, but no 3D unfortunately.
> 3. QorIQ P1022-based. Again dual core at 1Ghz (1055Mhz to be precise). Apart
> from the much lower chip price, this one includes dual gigabit ethernet,
> dual SATA, USB 2.0 and a 2D DIU display unit (same as the MPC8610). So this
>

Go for QorIQ P1022, it's the ideal SoC for many applications.

Alternatively, it's predecessor MPC8536E available now, ~same specs,
but higher power.  But not the two you mention please.

> End price is estimated to be ~around~ 350EUR for the P1022 board or ~500EUR
>
Pico P1022 or Pico MPC8536E pls.

and throw PCI Express (x4) in the party!

(hint: I haven't seen an Intel board with Atom and PCI Express yet).

Will the board be open hardware? I.e. an open sourced design?


Regards,
-- 
Leon
