Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 67466DE00D
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:32:06 +1000 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Oct 2007 14:48:55 MDT."
	<fa686aa40710081348p53c58bacw32b331a1eec56cdc@mail.gmail.com>
Date: Tue, 09 Oct 2007 00:32:02 +0200
Sender: wd@denx.de
Message-Id: <20071008223202.46BB82408C@gemini.denx.de>
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

In message <fa686aa40710081348p53c58bacw32b331a1eec56cdc@mail.gmail.com> you wrote:
>
> > > Why don't we fix it in U-Boot, then, and get rid of this in Linux?
> >
> > Mostly because I haven't gotten to it yet.  :-/
> 
> Actually, it's more than that.  I don't want to force users to upgrade
> their firmware on the lite5200.  Linux boots on it fine now with old
> firmware (using cuimage), it should continue to boot.  Doing board
> specific fixups at Linux setup_arch time to work around
> old/buggy/not-quite-what-we-want firmware is reasonable.  We must do
> this on the Efika too.

Maybe there's a way to allow booting with old firmware, but
nevertheless providing a technically clean, up to date version of
U-Boot for current kernels?

My point is that the Lite5200B is a reference design  -  many  people
copy the hardware design and use the code as starting point for their
own  board adaptions. So this port has to be as clean as possible, or
we will see the same remarks in nearly every new 5200 patch to come.

Please, let's clean this up.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I'm a programmer: I don't buy software, I write it.
                                                  -- Tom Christiansen
