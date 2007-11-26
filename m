Return-Path: <michel@tungstengraphics.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id DDE90DDE43
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 20:19:42 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so770014nfd
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 01:19:40 -0800 (PST)
Subject: Re: Access to PCI Expansion ROMs on PPC
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: "Robin H. Johnson" <robbat2@gentoo.org>
In-Reply-To: <20071126085928.GE14557@curie-int.orbis-terrarum.net>
References: <20071125015707.GO3174@curie-int.orbis-terrarum.net>
	<9e4733910711241813r3412d459l95fb3b84cbee1d8a@mail.gmail.com>
	<20071125111535.GB14557@curie-int.orbis-terrarum.net>
	<20071125114919.GC14557@curie-int.orbis-terrarum.net>
	<9e4733910711250530r454c01ecoe8867a7f492b8704@mail.gmail.com>
	<20071125194101.GD14557@curie-int.orbis-terrarum.net>
	<20071126085928.GE14557@curie-int.orbis-terrarum.net>
Content-Type: text/plain; charset=utf-8
Date: Mon, 26 Nov 2007 10:20:14 +0100
Message-Id: <1196068814.22865.108.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-11-26 at 00:59 -0800, Robin H. Johnson wrote:
> 
> Regarding the sub-thread on x86 emulation, that is totally out of scope
> for this. The 'AtomBIOS' of the ATI cards, consists of multiple parts (I
> may have minor errors here, ask airlied if you need more
> clarification):
> a) Initialization code (I think arch-specific)
> b) AtomBIOS script interpreter (I think arch-specific)
> c) AtomBIOS scripts (card-specific, but not arch-specific)
> d) Data tables (card-specific, but not arch-specific)
> 
> The AtomBIOS parts of the various drivers need data from c+d primarily,
> and provide their own script interpreter, or not using the scripts, just
> the data tables.

Are you sure the X1900 Mac Edition ROM contains any ATOM data structures
though? I rather doubt it.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer
