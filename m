Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DDB05B720A
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 02:21:46 +1000 (EST)
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id 396CFDDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 02:21:45 +1000 (EST)
Received: by gxk6 with SMTP id 6so3960030gxk.9
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 09:21:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.00.0906131109260.23298@localhost>
References: <alpine.LFD.2.00.0906131109260.23298@localhost>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sat, 13 Jun 2009 10:21:24 -0600
Message-ID: <fa686aa40906130921y51747e04se450697c7e2739bd@mail.gmail.com>
Subject: Re: invalid Kconfig "select" for MPC5121_ADS_CPLD
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 13, 2009 at 9:11 AM, Robert P. J. Day<rpjday@crashcourse.ca> wr=
ote:
>
> =A0arch/powerpc/platforms/512x/Kconfig: =A0select MPC5121_ADS_CPLD

5121 support in mainline is half-baked.  Wolfgang is working on a
patch series to update it (undergone one review cycle on the mailing
list).  I don't know if he has published a git tree containing the
current state.

BTW, it is helpful to cc: the relevant maintainers when asking
questions about particular SoCs.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
