Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 54BF2DDF3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Jul 2008 08:30:12 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1940397ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jul 2008 15:30:10 -0700 (PDT)
Message-ID: <9e4733910807221530vd5573d3oc2b56f544ab1c1f6@mail.gmail.com>
Date: Tue, 22 Jul 2008 18:30:10 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "=?ISO-8859-1?Q?Albrecht_Dre=DF?=" <albrecht.dress@arcor.de>
Subject: Re: [OT] write flash on MPC5200 board via jtag
In-Reply-To: <1216753011l.5683l.0l@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1216753011l.5683l.0l@antares>
Cc: LinuxPPC Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/22/08, Albrecht Dre=DF <albrecht.dress@arcor.de> wrote:
> Hi,
>
>  sorry for a somewhat off-topic question...
>
>  I want to design a mpc5200b board which is roughly derived from Freescal=
e's
> 5200B Lite demo.  Obviously, I have the problem to initially write u-boot
> into the boot nor flash.  I believe this would be possible using the
> jtag/bsm interface (is that true?).
>
>  Can you recommend any good hardware and software solution for that, if
> possible running on linux (OSS?)?  I don't need a "real" debugger (maybe =
an
> interface to gdb), just something to write the flash, so u-boot comes up.

I haven't tried it, but a Macraigor USB Wiggler supports the MPC5200
and it's $250.
http://www.macraigor.com/cpus.htm
That should be enough to write uboot into RAM. Once uboot is in RAM
you can use it to write the flash.

Let me know if you try it and it works.

>
>  Thanks for any help,
>  Albrecht.
>
> _______________________________________________
>  Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>


--=20
Jon Smirl
jonsmirl@gmail.com
