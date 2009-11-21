Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id 9400FB6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 Nov 2009 18:57:33 +1100 (EST)
Received: by gxk23 with SMTP id 23so4475518gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Nov 2009 23:57:31 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <OF627E4B93.73CDD8FE-ON6525766A.0013CA01-6525766A.0013C6E5@lntemsys.com>
References: <OF627E4B93.73CDD8FE-ON6525766A.0013CA01-6525766A.0013C6E5@lntemsys.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 21 Nov 2009 00:57:11 -0700
Message-ID: <fa686aa40911202357x206c1631xbfd8c098254ccf7f@mail.gmail.com>
Subject: Re: Fw: Help with SPI node
To: Ravi Shekhar <Ravi.Shekhar@lntemsys.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 9, 2009 at 8:36 PM, Ravi Shekhar <Ravi.Shekhar@lntemsys.com> wr=
ote:
>
>
> =A0I'm attempting to get SPI to work on my embedded design
> =A0that is based on the mpc8313erbd reference board wiht a
> =A02.6.27 kernel.

Are you able to use a more recent kernel?  A lot of work has gone into
SPI drivers in the last 5 releases.

> =A0I cannot open the SPI device.
> =A0Tracing through the kernel code, it looks like the device is
> =A0not being found in the DTB file. =A0However there is a
> =A0SPI node in there already described. =A0Our boards is a
> SPI master, and the device we will attach is a SPI
> =A0slave. =A0Could someone elaborate on what is needed in
> =A0the DTS file to have our SPI driver work and respond to an
> =A0open() call?

Look in Documentation/powerpc/dts-bindings/spi-bus.txt.  However, the
2.6.27 kernel may not have support for that binding on the mpc8313 SPI
bus driver (I'm not sure though, I haven't looked).

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
