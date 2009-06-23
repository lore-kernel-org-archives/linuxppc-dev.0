Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1715FB70B7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 02:42:23 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id 732CEDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 02:42:21 +1000 (EST)
Received: by yxe37 with SMTP id 37so312863yxe.17
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Jun 2009 09:42:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A410351.4050508@marel.com>
References: <20090618025030.12363.69402.stgit@localhost.localdomain>
	<4A40E940.10201@marel.com>
	<fa686aa40906230853t5db35b11wae09cf46634d4758@mail.gmail.com>
	<4A410351.4050508@marel.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 23 Jun 2009 10:41:59 -0600
Message-ID: <fa686aa40906230941r1b0dbf1bh325366823d01ebfa@mail.gmail.com>
Subject: Re: [PATCH v4] powerpc/5200: Add mpc5200-spi (non-PSC) device driver
To: =?ISO-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kari.davidsson@marel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 23, 2009 at 10:31 AM, K=E1ri
Dav=ED=F0sson<kari.davidsson@marel.com> wrote:
> Lowered my SPI clock down to 1MHz (from 50MHz (in steps of 10MHz).
> At 1Mhz the driver stops starving the rest of the kernel.
>
> What is interesting is that due to the low duty cycle of the SPI port
> the transfer rate at 1MHz and 50Mhz is almost the same.
>
> I suggest that the driver simply limits max frequency to 1Mhz.

Sounds good to me.  Thanks for the testing!

> This (very limited) SPI pherperial does not handle any more anyways.

indeed.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
