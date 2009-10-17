Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 2CE0CB7B74
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2009 05:12:28 +1100 (EST)
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Mixing hard and soft floating point?
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se>
References: <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se>
Date: Sat, 17 Oct 2009 20:12:24 +0200
Message-Id: <20091017181224.97FFBF15432@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Joakim Tjernlund,

In message <OFC920E57F.DFABC29F-ONC1257652.00421E11-C1257652.0043478A@transmode.se> you wrote:
> 
> Anyone tried mixing hard and soft FP in on soft float CPU such as 83xx?

Hm... most 83xx have a FPU.

> Been trying to figure out if this is a good idea or not.
> Any combinations that will or won't work?

What exactly do you mean by "mixing"? You cannot (at least not with
any reasonable effort) mix hard and soft FP in the same application /
linked object. And it would be pretty difficult to setup separate
libraries for and all that stuff for both hard and soft FP binaries
in one system.

I doubt if such a setup makes sense at all.

> Generally I got soft FP in all system libs but there might be
> an binary application which will use hard FP.

Recompile and relink it with soft-fp as well. Or ask the provider to
do that.

> Is the MATH_EMU option in the kernel reliable(for 8xx too)?

It's reliable enough to install and run standard  distributions  like
Debian, Ubuntu, or Fedora, but I have to admit that we haven't stress
tested any special FP test suites in such an environment. In everyday
use I didn't see any real issues, though.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
If I can have honesty, it's easier to overlook mistakes.
	-- Kirk, "Space Seed", stardate 3141.9
