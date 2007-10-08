Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 60AE1DDF42
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 17:44:12 +1000 (EST)
To: "Grant Likely" <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 Oct 2007 00:21:54 MDT."
	<fa686aa40710072321g3494b243w341e2b09117c3695@mail.gmail.com>
Date: Mon, 08 Oct 2007 09:44:09 +0200
Sender: wd@denx.de
Message-Id: <20071008074409.5A6BE2486E@gemini.denx.de>
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

In message <fa686aa40710072321g3494b243w341e2b09117c3695@mail.gmail.com> you wrote:
>
> > +       port_config &= ~0x03000000;     /* ATA CS is on csb_4/5         */
> > +       port_config |=  0x01000000;
> 
> Are you *sure* you want this?  You should only be touching port_config
> if firmware fails to set it up correctly.  Don't blindly copy what was
> done for the lite5200.
> 
> Lite5200 touches it because firmware does *not* do the right thing at
> the moment.

Why don't we fix it in U-Boot, then, and get rid of this in Linux?


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The average woman would rather have beauty than brains,  because  the
average man can see better than he can think.
