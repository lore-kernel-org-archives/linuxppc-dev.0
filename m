Return-Path: <marc.leeman@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.203])
	by ozlabs.org (Postfix) with ESMTP id EDEC32BDB5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Nov 2004 00:28:21 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id j1so468059rnf
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Nov 2004 05:28:14 -0800 (PST)
Message-ID: <1f729c480411180528dafdf2b@mail.gmail.com>
Date: Thu, 18 Nov 2004 14:28:13 +0100
From: Marc Leeman <marc.leeman@gmail.com>
To: Linux PPC Mailing List <linuxppc-dev@ozlabs.org>
In-Reply-To: <1f729c48041117075151960f69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1f729c480411110036445cd8aa@mail.gmail.com>
	<1f729c48041117075151960f69@mail.gmail.com>
Subject: Re: 2.4 -> 2.6: problem probing PCI
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Anyway, insights are welcome, I'm still investigating...

Found it, I used the wrong arc/ppc/platforms file after too zealous
cleanup of the code. I need some final testing but it looks like this
will be the only file that needs update (considering the PCI mapping
and scanning).

--=20
ash nazg durbatul=FBk, ash nazg gimbatul,
ash nazg thrakatul=FBk agh burzum-ishi krimpatul
