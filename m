Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id E13D7DE107
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 17:54:16 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so640756rvf
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 00:54:16 -0700 (PDT)
Message-ID: <fa686aa40710080054l4099c78cxb4817c413696e569@mail.gmail.com>
Date: Mon, 8 Oct 2007 01:54:15 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
In-Reply-To: <20071008074409.5A6BE2486E@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710072321g3494b243w341e2b09117c3695@mail.gmail.com>
	<20071008074409.5A6BE2486E@gemini.denx.de>
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
> In message <fa686aa40710072321g3494b243w341e2b09117c3695@mail.gmail.com> you wrote:
> >
> > > +       port_config &= ~0x03000000;     /* ATA CS is on csb_4/5         */
> > > +       port_config |=  0x01000000;
> >
> > Are you *sure* you want this?  You should only be touching port_config
> > if firmware fails to set it up correctly.  Don't blindly copy what was
> > done for the lite5200.
> >
> > Lite5200 touches it because firmware does *not* do the right thing at
> > the moment.
>
> Why don't we fix it in U-Boot, then, and get rid of this in Linux?

Mostly because I haven't gotten to it yet.  :-/

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
