Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 58A6EDDF8F
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:37:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1914231wag
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 15:37:13 -0700 (PDT)
Message-ID: <fa686aa40710081537i69d22c10g62ec54f73c194871@mail.gmail.com>
Date: Mon, 8 Oct 2007 16:37:13 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
In-Reply-To: <20071008223202.46BB82408C@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710081348p53c58bacw32b331a1eec56cdc@mail.gmail.com>
	<20071008223202.46BB82408C@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, tech-denx@semihalf.com,
	Detlev Zundel <dzu@denx.de>, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/8/07, Wolfgang Denk <wd@denx.de> wrote:
> In message <fa686aa40710081348p53c58bacw32b331a1eec56cdc@mail.gmail.com> you wrote:
> >
> > > > Why don't we fix it in U-Boot, then, and get rid of this in Linux?
> > >
> > > Mostly because I haven't gotten to it yet.  :-/
> >
> > Actually, it's more than that.  I don't want to force users to upgrade
> > their firmware on the lite5200.  Linux boots on it fine now with old
> > firmware (using cuimage), it should continue to boot.  Doing board
> > specific fixups at Linux setup_arch time to work around
> > old/buggy/not-quite-what-we-want firmware is reasonable.  We must do
> > this on the Efika too.
>
> Maybe there's a way to allow booting with old firmware, but
> nevertheless providing a technically clean, up to date version of
> U-Boot for current kernels?
>
> My point is that the Lite5200B is a reference design  -  many  people
> copy the hardware design and use the code as starting point for their
> own  board adaptions. So this port has to be as clean as possible, or
> we will see the same remarks in nearly every new 5200 patch to come.
>
> Please, let's clean this up.

Yes, I agree.  I need to think about this a bit.  In the mean time,
I've submitted a lite5200 patch that makes it clear the CPU setup
fixups are *not* common code and should *not* be duplicated.  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
