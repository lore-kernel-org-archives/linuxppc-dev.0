Return-Path: <richard.cochran@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D7764B7B78
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 23:21:04 +1100 (EST)
From: Richard Cochran <richard.cochran@omicron.at>
To: "'Scott Wood'" <scottwood@freescale.com>
Date: Thu, 15 Oct 2009 14:19:30 +0200
Subject: RE: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E30E2AE72C@alice.at.omicron.at>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
	<95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
	<20091014152722.GA17867@b07421-ec1.am.freescale.net>
In-Reply-To: <20091014152722.GA17867@b07421-ec1.am.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>-----Original Message----- From: Scott Wood [mailto:scottwood@freescale.co=
m]
>Because that would be three times the device trees to maintain, and a
>source of user confusion.

I wonder which is more confusing for the user:

1. Choosing one of three dts files.
2. Having only one dts for his board, but Ethernet doesn't work.

Richard
