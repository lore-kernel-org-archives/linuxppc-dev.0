Return-Path: <marcelo.tosatti@cyclades.com>
Received: from www.linux.org.uk (parcelfarce.linux.theplanet.co.uk
	[195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B77C2BDCF
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Oct 2004 03:52:55 +1000 (EST)
Date: Fri, 15 Oct 2004 12:47:31 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20041015154731.GA3957@logos.cnet>
References: <20040921103503.54102.qmail@web15607.mail.cnb.yahoo.com>
	<4150056E.9050300@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4150056E.9050300@intracom.gr>
Cc: linuxppc-dev@ozlabs.org, Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 21, 2004 at 01:41:50PM +0300, Pantelis Antoniou wrote:
> Song Sam wrote:
>=20
> >Pantelis Antoniou <panto@intracom.gr> wrote=A3=BA
> >
> >>Well it works OK until it gets to start init.
> >>
> >>Then it crashes the way it is supposed to :).
> >>
> >>Tom I think it's the problem we are talking about.
> >>
> >>Song please try this...
> >>
> >
> >Guess what? It WORKED!!! Just one more line make it.
> >Could you pls tell us the theory in it if not too
> >complicated? :-)
> >
> >Well Done!
> >
> Oh man Dan will kill me :)
>=20
> The theory is simple, TLB handling is faulty for 8xx.
>=20
> This patch fixes it but Dan & Ben think it's just by
> coincedence and we should fix it properly.

Hi Pantelis, others,

And what has to be done to be fixed properly?=20

Ie what is the problem in detail?
