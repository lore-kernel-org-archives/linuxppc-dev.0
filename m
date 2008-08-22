Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 235A2DE37C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Aug 2008 05:44:18 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] AMCC PPC460GT/EX PCI-E de-emphasis adjustment fix
Date: Fri, 22 Aug 2008 21:44:15 +0200
References: <1219380814-17229-1-git-send-email-fkan@amcc.com>
	<20080822133020.GE22283@yoda.jdub.homelinux.org>
In-Reply-To: <20080822133020.GE22283@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808222144.15235.sr@denx.de>
Cc: Tirumala R Marri <tmarri@amcc.com>, fkan@amcc.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 22 August 2008, Josh Boyer wrote:
> On Thu, Aug 21, 2008 at 09:53:34PM -0700, fkan@amcc.com wrote:
> >From: Tirumala R Marri <tmarri@amcc.com>
> >
> >During recent tests with PCI-E , it has been found the
> >DRV + De-Emphasis values are not optimum. These new values
> >are tested thouroughly.
> >
> >Signed-off-by: Tirumala R Marri <tmarri@amcc.com>
>
> If you are sending out a patch for someone, you need to include your
> Signed-off-by as well.  Just reply to this with it, no need to resend
> the just for this.
>
> Stefan, this looks good to me.  Or at least as far as I can tell from
> the somewhat magic values :)  Any comments?

Looks good for me too, so:

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
