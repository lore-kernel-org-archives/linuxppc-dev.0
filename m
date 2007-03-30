Return-Path: <tmaenner@aehr.com>
Received: from loki.aehr.com (loki.aehr.com [207.168.29.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D9F0DDEB7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Mar 2007 16:00:15 +1000 (EST)
From: Thomas Maenner <tmaenner@aehr.com>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Avoid using libm in rootfs
Date: Thu, 29 Mar 2007 22:59:48 -0700
References: <20070329212746.E8F36353A6C@atlas.denx.de>
In-Reply-To: <20070329212746.E8F36353A6C@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703292259.48579.tmaenner@aehr.com>
Cc: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Wolfgang, I saw the trouble ;)

Just for the rest, who might be struggling here:
Switched back to ELDK 3.1.1, kernel 2.4.25, busybox 1.4.2 and things worked 
fine again.

Thanks much!
Tom

On Thursday 29 March 2007 14:27, Wolfgang Denk wrote:
> In message <200703291345.35978.tmaenner@aehr.com> you wrote:
> > Maybe on the same subject or OT, I'm having trouble with ELDK 4.1.0,
> > kernel 2.4.25, u-boot 1.1.6, kernel and ramdisk copied from flash into
> > RAM on a TQM860L module.
>
> Using ELDK 4.1 (= a toolchain build for a  2.6  kernel)  with  a  2.4
> kernel  is  not  a supported mode of operation. Please use ELDK 3.1.1
> for runtime environment of your 2.4 kernel.
>
> > Shouldn't the paths from ldd be for example /lib/libc.so.6 ?
>
> No, the cross-version of ldd shows the full path name in the cross
> environment.
>
> > Anybody has any idea what that could be?
>
> Incompatibility of libraries. Use ELDK 3.x with 2.4 kernels, and ELDK
> 4.x with 2.6 kernels; anything else is asking for trouble.
>
> Best regards,
>
> Wolfgang Denk

-- 
Thomas Maenner
E-Mail: mailto:tmaenner@aehr.com
