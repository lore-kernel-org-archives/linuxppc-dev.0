Return-Path: <pinskia@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by ozlabs.org (Postfix) with ESMTP id BB80ADDF06
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 06:22:24 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1360914rvf.9
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 11:22:18 -0800 (PST)
Message-ID: <de8d50360802181122k63410760y9a61f4c42ff251f8@mail.gmail.com>
Date: Mon, 18 Feb 2008 11:22:18 -0800
From: "Andrew Pinski" <pinskia@gmail.com>
To: "Geert Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [Cbe-oss-dev] [PATCH 1/3] Fix Unlikely(x) == y
In-Reply-To: <Pine.LNX.4.64.0802181500410.13406@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
	<20080216103927.2a02352b@laptopd505.fenrus.org>
	<1203249003.6718.24.camel@concordia>
	<20080218135609.GD21080@cs181133002.pp.htv.fi>
	<Pine.LNX.4.64.0802181500410.13406@vixen.sonytel.be>
Cc: Adrian Bunk <bunk@kernel.org>, Roel Kluin <12o3l@tiscali.nl>,
	lkml <linux-kernel@vger.kernel.org>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org, Willy Tarreau <w@1wt.eu>,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 18, 2008 6:01 AM, Geert Uytterhoeven
<Geert.Uytterhoeven@sonycom.com> wrote:
> > This means it generates faster code with a current gcc for your platform.
> >
> > But a future gcc might e.g. replace the whole loop with a division
> > (gcc SVN head (that will soon become gcc 4.3) already does
> > transformations like replacing loops with divisions [1]).

Yes but the issue is one optimization inside GCC does not take into
account the probability in one case.

And really there is a bug in the linux kernel for not implementing the
long long divide function (or really using libgcc) but that is a
different story and is part of the issue there anyways.

-- Pinski
