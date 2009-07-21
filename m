Return-Path: <Bob.Burke@terascala.com>
Received: from hermes.terascala.com (terascala.com [75.147.14.129])
	by bilbo.ozlabs.org (Postfix) with ESMTP id E497CB7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jul 2009 01:56:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] PowerPC 440EPx: Sequoia bootwrapper
Date: Tue, 21 Jul 2009 11:56:40 -0400
Message-ID: <2C7DE72B9BD00F44BAECA5B0CBB873956CDC46@hermes.terascala.com>
In-Reply-To: <200907211606.52572.sr@denx.de>
From: "Bob Burke" <Bob.Burke@terascala.com>
To: "Stefan Roese" <sr@denx.de>,
	<linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Jul 2009 16:06:53 Stefan Roese wrote:
>  Unfortunately it's not that easy. Earlier Sequoia board revisions are
>  equipped with an 33.333MHz oscillator. This can be detected via a
CPLD
>  register though.

Thanks, I didn't realize that. FYI our deployed platform is similar to
Sequoia,
but is a custom design. It has a 33 MHz system clock.

>  But why are you using the boot wrapper? If your U-Boot isn't too old,
you can
>  boot uImage directly (with dtb of course). No need for the wrapper.

Since we have deployed product, using a non OF kernel, we have made the
decision
not to upgrade U-Boot in the field.

Thanks,
Bob
