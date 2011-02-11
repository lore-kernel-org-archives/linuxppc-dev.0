Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5E005B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Feb 2011 06:16:17 +1100 (EST)
Received: by iwb12 with SMTP id 12so2897982iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 11:16:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTin+1pENJ_CNQGoPA=Hisv4qkJWCE01uyZEXipNu@mail.gmail.com>
References: <AANLkTikAVgH9-UQfrjoAJSemet5p_PxhxCdot8cChQu3@mail.gmail.com>
	<AANLkTim6v25Sam+E8Bo9za1q0GJqWZitgqR0KBuKCoWz@mail.gmail.com>
	<AANLkTik9ejmu2vE13f_nRZZMspU-LW4y2=74iczoXGNt@mail.gmail.com>
	<AANLkTikGK-7JspQMTiqjXcvoP1FVSt2gZJ9SRqGj=7DO@mail.gmail.com>
	<1296682842.2349.730.camel@pasglop>
	<AANLkTi=xM5qt4sic-YBD87Znt0vVOyX2yOyhODhtKNqC@mail.gmail.com>
	<AANLkTin+1pENJ_CNQGoPA=Hisv4qkJWCE01uyZEXipNu@mail.gmail.com>
Date: Fri, 11 Feb 2011 13:16:14 -0600
Message-ID: <AANLkTimKp9FX3a6WU8Rp+3AgtHT6eXHEp_jk8ExXtVut@mail.gmail.com>
Subject: Re: BootX
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

Hi,

I have looked at the -S output for mesh.c from both 4.1.2 and 4.3.5.
The generated code is quite different but I can not see any difference
that is causing the problem?

If I read and print the bus status register 0, it does appear to have
the busy bit set?

I'm in way over my head here. It appears to complete a pair of
inquiries (one with a small data buffer and a second with a larger
one) to each target. It then tries a test unit ready but discovers the
bus busy?

ANY suggestions welcome and appreciated!

Thanks!
