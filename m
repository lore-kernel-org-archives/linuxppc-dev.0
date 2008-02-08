Return-Path: <SRS0=TUrV=S5=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 7D397DDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 01:32:54 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] MTD support for the AMCC Taishan
Date: Fri, 8 Feb 2008 15:32:42 +0100
References: <120203530465-git-send-email-kaloz@openwrt.org>
	<200802081527.28771.sr@denx.de>
In-Reply-To: <200802081527.28771.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802081532.42717.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 February 2008, Stefan Roese wrote:
> > +					partition@380000 {
> > +						label = "user";
> > +						reg = <380000 3a80000>;
> > +					};
> > +					partition@3e00000 {
> > +						label = "kozio";
> > +						reg = <3e00000 140000>;
> > +					};
>
> Please remove the kozio partition from this list. It's not used/supported
> anymore.

And please extend the "user" partition accordingly.

Thanks.

Best regards,
Stefan
