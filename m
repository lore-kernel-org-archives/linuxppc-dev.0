Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 9C0CCDDFF7
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 06:48:56 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1886726wag
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Oct 2007 13:48:55 -0700 (PDT)
Message-ID: <fa686aa40710081348p53c58bacw32b331a1eec56cdc@mail.gmail.com>
Date: Mon, 8 Oct 2007 14:48:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: [POWERPC 03/15] [POWERPC] TQM5200 board support
In-Reply-To: <fa686aa40710080054l4099c78cxb4817c413696e569@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40710072321g3494b243w341e2b09117c3695@mail.gmail.com>
	<20071008074409.5A6BE2486E@gemini.denx.de>
	<fa686aa40710080054l4099c78cxb4817c413696e569@mail.gmail.com>
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

On 10/8/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 10/8/07, Wolfgang Denk <wd@denx.de> wrote:
> > In message <fa686aa40710072321g3494b243w341e2b09117c3695@mail.gmail.com> you wrote:
> > > Lite5200 touches it because firmware does *not* do the right thing at
> > > the moment.
> >
> > Why don't we fix it in U-Boot, then, and get rid of this in Linux?
>
> Mostly because I haven't gotten to it yet.  :-/

Actually, it's more than that.  I don't want to force users to upgrade
their firmware on the lite5200.  Linux boots on it fine now with old
firmware (using cuimage), it should continue to boot.  Doing board
specific fixups at Linux setup_arch time to work around
old/buggy/not-quite-what-we-want firmware is reasonable.  We must do
this on the Efika too.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
