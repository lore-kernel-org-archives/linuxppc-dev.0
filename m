Return-Path: <tmaenner@aehr.com>
Received: from loki.aehr.com (loki.aehr.com [207.168.29.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF8DADDE02
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Mar 2007 04:27:08 +1100 (EST)
From: Thomas Maenner <tmaenner@aehr.com>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: TQM 860L, 64MB RAM, ELDK4.1, TQM860L, Kernel 2.6.19
Date: Fri, 23 Mar 2007 10:26:31 -0700
References: <20070322212615.553FE35260B@atlas.denx.de>
In-Reply-To: <20070322212615.553FE35260B@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703231026.31387.tmaenner@aehr.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Apparently I was not aware, that the TQ8xx are not supported by 2.6...
Will try the linuxppc_2_4_devel version from your cvs repository.

Thanks
Tom

On Thursday 22 March 2007 14:26, Wolfgang Denk wrote:
> In message <200703221410.37767.tmaenner@aehr.com> you wrote:
> > Tried out the following u-boot "setting":
> > setenv ramargs setenv bootargs ramdisk_size=6144 root=/dev/ram
> > console=ttyCPM0 rw
> >
> > No change; still no output in the console
>
> Then buy a debugger and dig into it...
>
> > Note that my module has 64MB, rather that 16; I thought it doesn't
> > matter, or?
>
> It doesn't.
>
> You are aware that TQM8xxL is not yet supported in the context of the
> 2.6 Linux kernel, aren't you? [And we will  not  support  it  in  the
> ARCH=ppc context any more.]
>
> Best regards,
>
> Wolfgang Denk

-- 
Thomas Maenner
E-Mail: mailto:tmaenner@aehr.com
