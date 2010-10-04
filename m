Return-Path: <tmarri@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	by ozlabs.org (Postfix) with SMTP id 8EC97B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 04:31:41 +1100 (EST)
Received: by mail-ey0-f178.google.com with SMTP id 6so1959564eyh.9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Oct 2010 10:31:39 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1285865736-32074-1-git-send-email-tmarri@apm.com>
	<20100930190814.52268D2B48C@gemini.denx.de>
	<AANLkTi=CJOsayM1YnwE3a22D2S35aM+BTV6_YfXjcjiO@mail.gmail.com>
	<dc9b5d064d80ac2af2ccf932e94b2bb9@mail.gmail.com>
	<AANLkTi=JqTU898DfW1=4qcb2WbwHvroY6LqiAX_oBb5L@mail.gmail.com>
	<20101002184957.GA17774@kroah.com>
In-Reply-To: <20101002184957.GA17774@kroah.com>
MIME-Version: 1.0
Date: Mon, 4 Oct 2010 10:30:31 -0700
Message-ID: <070fbd9a32bf18957bc2ecda9a476d7d@mail.gmail.com>
Subject: RE: [PATCH] PPC4xx: ADMA separating SoC specific functions
To: Greg KH <greg@kroah.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-raid@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>, yur@emcraft.com, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >
> > You definitely need to be able to resolve "used but not defined" and
> > "defined but not used" warnings before tackling a driver conversion
> > like this.  In light of this comment I wonder if it would be
> > appropriate to submit your original driver, that just duplicated
> > routines from the ppc440spe driver, to the -staging tree.  Then it
> > would be available for someone familiar with driver conversions to
> > take a shot at unifying.
> >
> > Greg, is this an appropriate use of -staging?
>
> Possibly, but I really don't like duplication if possible.  What's
> keeping this code from being fixed up now properly?

[Marri] Hello Greg, I am working on restructuring ppc4xx/adma.c driver
into
Common code and SoC specific code. This way I can add support for similar
DMA engines.
In this process I had to declare some Of the functions non static so that
I can suppress "defined but not used" and "used but not defined".


Here is what series of patches I planned to work on.

1. First set patches to re-arrange the code. Functionally no change except
Structured into different files.
2. Second set to rename the common functions which are shared between SoC
dma-engines.
3. Add support of new DMA engine for different SoC.

I am working on first patch set right now.


Regards,
Marri
