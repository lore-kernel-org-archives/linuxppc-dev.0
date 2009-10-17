Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E5490B7B7A
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 05:29:04 +1100 (EST)
In-Reply-To: <20091017181224.97FFBF15432@gemini.denx.de>
References: <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se>
	<20091017181224.97FFBF15432@gemini.denx.de>
Subject: Re: Mixing hard and soft floating point?
To: Wolfgang Denk <wd@denx.de>
Message-ID: <OFEC00B9FB.B03AA854-ONC1257652.00644350-C1257652.00651551@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 17 Oct 2009 20:24:05 +0200
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

Wolfgang Denk <wd@denx.de> wrote on 17/10/2009 20:12:24:
>
> Dear Joakim Tjernlund,
>
> In message <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.
> 0043478A@transmode.se> you wrote:
> >
> > Anyone tried mixing hard and soft FP in on soft float CPU such as 83xx?
>
> Hm... most 83xx have a FPU.

Yeah, I meant 832x. These don't have a FPU

>
> > Been trying to figure out if this is a good idea or not.
> > Any combinations that will or won't work?
>
> What exactly do you mean by "mixing"? You cannot (at least not with
> any reasonable effort) mix hard and soft FP in the same application /
> linked object. And it would be pretty difficult to setup separate
> libraries for and all that stuff for both hard and soft FP binaries
> in one system.

I meant on per app or per lib basis, not within the same
app/lib.

>
> I doubt if such a setup makes sense at all.
>
> > Generally I got soft FP in all system libs but there might be
> > an binary application which will use hard FP.
>
> Recompile and relink it with soft-fp as well. Or ask the provider to
> do that.

That is what I am trying do/find out. The supplier claims that
it should not be a problem and is ATM unwilling to recompile the app/libs.
I am not convinced won't cause problems, not to mention performance degradation.

>
> > Is the MATH_EMU option in the kernel reliable(for 8xx too)?
>
> It's reliable enough to install and run standard  distributions  like
> Debian, Ubuntu, or Fedora, but I have to admit that we haven't stress
> tested any special FP test suites in such an environment. In everyday
> use I didn't see any real issues, though.

OK, but then you don't mix some libs/apps with soft and other
apps/libs with hard FP?

  Jocke
