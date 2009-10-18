Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3195CB7B9A
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 22:32:15 +1100 (EST)
In-Reply-To: <20091017193454.7978FF15432@gemini.denx.de>
References: <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se>
	<20091017181224.97FFBF15432@gemini.denx.de>
	<OFEC00B9FB.B03AA854-ONC1257652.00644350-C1257652.00651551@transmode.se>
	<20091017193454.7978FF15432@gemini.denx.de>
Subject: Re: Mixing hard and soft floating point?
To: Wolfgang Denk <wd@denx.de>
Message-ID: <OFEFBDE7C9.DA9D5B8B-ONC1257653.003E3DC6-C1257653.003F0B37@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 18 Oct 2009 13:28:36 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Wolfgang Denk <wd@denx.de> wrote on 17/10/2009 21:34:54:
>
> Dear Joakim Tjernlund,
>
> In message <OFEC00B9FB.B03AA854-ONC1257652.00644350-C1257652.
> 00651551@transmode.se> you wrote:
> >
> > > Recompile and relink it with soft-fp as well. Or ask the provider to
> > > do that.
> >
> > That is what I am trying do/find out. The supplier claims that
> > it should not be a problem and is ATM unwilling to recompile the app/libs.
> > I am not convinced won't cause problems, not to mention performance degradation.
>
> If the application is really using FP instructions a lot, then there
> is a huge difference between using soft-float and MATH_EMU; I
> remember test cases where soft-float was faster by factors of
> 500...1000.

Ouch, I had no idea that it could be that much.

>
> > OK, but then you don't mix some libs/apps with soft and other
> > apps/libs with hard FP?
>
> No, we never tried that. Sounds scary to me.

Yes, it did to me too. That is why I figured I should ask on the
list.
