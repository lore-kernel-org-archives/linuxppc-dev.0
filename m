Return-Path: <paul.gortmaker@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id BF65BDE02B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 11:33:00 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so1007738ywj.39
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 18:32:44 -0700 (PDT)
Message-ID: <7d1d9c250804141832pa9c9fbbicf4939c9854dc5f5@mail.gmail.com>
Date: Mon, 14 Apr 2008 21:32:44 -0400
From: "Paul Gortmaker" <paul.gortmaker@gmail.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
In-Reply-To: <28ac27892f91a47cd620aee7b7b9ecdb@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
	<20080411171628.GA3203@loki.buserror.net>
	<20080411184312.GA23941@windriver.com>
	<28ac27892f91a47cd620aee7b7b9ecdb@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 3:11 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > Updated as per above, and with tickerized prefixes for sbc8641.
> >
>
>  Care to try once more?  It's only "tickerized" if it's in all
>  uppercase.

I'm looking at what exists in arch/powerpc/boot/dts/* and I'm
not seeing too much uppercase - here is a sample:

ebony.dts:        compatible = "ibm,ebony";
ep405.dts:        compatible = "ibm,uic";
ep8248e.dts:    compatible = "fsl,ep8248e";
bamboo.dts:     compatible = "amcc,bamboo";
cm5200.dts:     compatible = "schindler,cm5200";
ep88xc.dts:     compatible = "fsl,ep88xc";
haleakala.dts:  compatible = "amcc,kilauea";
holly.dts:         compatible = "ibm,holly";
katmai.dts:     compatible = "amcc,katmai";
kilauea.dts:    compatible = "amcc,kilauea";
lite5200b.dts:  compatible = "fsl,lite5200b";
motionpro.dts:  compatible = "promess,motionpro";
mpc8272ads.dts: compatible = "fsl,mpc8272ads";
mpc866ads.dts:  compatible = "fsl,mpc866ads";

> > +       compatible = "wind,sbc8641";

To me this looks in keeping with the rest.  And I prefer
with the lower case, actually.  (Apparently so do a lot of
other people...)

Paul.

> >
>
>
>  Segher
>
>
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
