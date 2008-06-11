Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 0C73FDDEED
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jun 2008 17:03:01 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Wolfgang Denk <wd@denx.de>
Subject: Ooops... Re: [PATCH] prtlvt board support (MPC5121e) added
Date: Wed, 11 Jun 2008 08:39:11 +0200
References: <20080610203511.B34AD2487D@gemini.denx.de>
In-Reply-To: <20080610203511.B34AD2487D@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806110839.11512.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 10 June 2008 22:35:11 you wrote:
> In message <200806101842.36755.david@protonic.nl> you wrote:
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  arch/powerpc/boot/dts/prtlvt.dts     |  280
> > ++++++++++++++++++++++++++++++++++ arch/powerpc/platforms/512x/Kconfig  |
> >    9 +
> >  arch/powerpc/platforms/512x/Makefile |    1 +
> >  arch/powerpc/platforms/512x/prtlvt.c |  105 +++++++++++++
> >  4 files changed, 395 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/powerpc/boot/dts/prtlvt.dts
> >  create mode 100644 arch/powerpc/platforms/512x/prtlvt.c
>
> This doesn't apply on top of the original LTIB source tree:

It was meant for application on denx git master head, not LTIB, which is 
outdated. 

Anyway, this patch was sent by accident. Sorry for that mistake. 

My intention is to end up with full MPC5121 support in mainline kernel. The 
first step (for me) was our BSP. Then a patch to make fs_enet working would 
follow. I have that one prepared also, but it is still not quite right... I 
am still fighting with git about it ;-)

It was very late yesterday, and I am still learning how to use GIT correctly. 
I prepared the e-mail for submission (more to see how its done, than with the 
true intention of actually sending it), and must have hit the "send" button 
by accident. I was supposed to review this patch first, and now Grant won the 
race ;-)

I was in the middle of trying to figure out how to fill in the right e-mail 
headers automatically with git-format-patch.

So I believe it was a beginners mistake, sorry for that, and thanks for 
reviewing it anyway...

Greetings,

-- 
David Jander
Protonic Holland.
