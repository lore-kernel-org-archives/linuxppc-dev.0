Date: Mon, 18 Mar 2002 14:56:04 -0800
From: andrew may <acmay@acmay.homeip.net>
To: Armin <akuster@pacbell.net>
Cc: andrew may <acmay@acmay.homeip.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] another for ibm_ocp_enet gzip'd
Message-ID: <20020318145604.B6687@ecam.san.rr.com>
References: <20020315114137.A26609@ecam.san.rr.com> <20020315200558.GG691@opus.bloom.county> <20020315142542.A27043@ecam.san.rr.com> <20020315223140.GA1643@opus.bloom.county> <20020318142507.A6687@ecam.san.rr.com> <3C95FF7C.7050300@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C95FF7C.7050300@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Mar 18, 2002 at 02:53:48PM +0000, Armin wrote:
> andrew may wrote:
>
> > +#Do we want CONFIG_IBM_OCP_MAL_CNT ?
>
> No

Well then you get to update the makefile when
we start having more MALs around.

> > +ibm_ocp_mal.c: mal.sh
> > +	$(SH) ./mal.sh 2 >ibm_ocp_mal.c
> > +
> >
>
>
> And this get applied on top of your first patch?

Yes, how else would get mal.sh. There was the first
patch, and a second patch that fixed up mal.sh.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
