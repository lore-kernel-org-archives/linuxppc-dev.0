Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 5CD49B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jul 2009 02:52:22 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: "Bob Burke" <Bob.Burke@terascala.com>
Subject: Re: [PATCH] PowerPC 440EPx: Sequoia bootwrapper
Date: Tue, 21 Jul 2009 18:52:12 +0200
References: <2C7DE72B9BD00F44BAECA5B0CBB873956CDC46@hermes.terascala.com>
In-Reply-To: <2C7DE72B9BD00F44BAECA5B0CBB873956CDC46@hermes.terascala.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200907211852.12901.sr@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 21 July 2009 17:56:40 Bob Burke wrote:
> On Tue, 21 Jul 2009 16:06:53 Stefan Roese wrote:
> >  Unfortunately it's not that easy. Earlier Sequoia board revisions are
> >  equipped with an 33.333MHz oscillator. This can be detected via a
> >  CPLD register though.
>
> Thanks, I didn't realize that. FYI our deployed platform is similar to
> Sequoia,
> but is a custom design. It has a 33 MHz system clock.

OK. Then you should add a new target for your custom board (cuboot-namexyz.c).

> >  But why are you using the boot wrapper? If your U-Boot isn't too old,
> >  you can  boot uImage directly (with dtb of course). No need for the
> >  wrapper.
>
> Since we have deployed product, using a non OF kernel, we have made the
> decision not to upgrade U-Boot in the field.

OK, understood.

Thanks,
Stefan
