Return-Path: <richard.cochran@omicron.at>
Received: from ns.omicron.at (ns.omicron.at [212.183.10.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F2E6AB7B6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 19:47:19 +1100 (EST)
From: Richard Cochran <richard.cochran@omicron.at>
To: "'Scott Wood'" <scottwood@freescale.com>, "'Roland Lezuo'"
	<roland.lezuo@chello.at>
Date: Wed, 14 Oct 2009 09:41:33 +0200
Subject: RE: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
Message-ID: <95DC1AA8EC908B48939B72CF375AA5E30E220693@alice.at.omicron.at>
References: <25940478.1252060285938.JavaMail.root@viefep11.chello.at>
	<20090909182227.GA8215@b07421-ec1.am.freescale.net>
In-Reply-To: <20090909182227.GA8215@b07421-ec1.am.freescale.net>
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

>-----Original Message-----
>From: linuxppc-dev-bounces On Behalf Of Scott Wood
>Sent: Wednesday, September 09, 2009 8:22 PM
>To: Roland Lezuo
>Cc: linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH] * mpc8313erdb.dts: Fixed eTSEC interrupt assignment.
>
>On Fri, Sep 04, 2009 at 12:31:25PM +0200, Roland Lezuo wrote:
>> The following patch is needed to correctly assign the IRQs for the
>> gianfar driver on the MPC8313ERDB-revc boards. ERR and TX are swapped
>> as well as the interrupt lines for the two devices.
>
>And it will incorrectly assign them on older revisions of the chip.
>
>We really should have a u-boot fixup based on SVR.

Why not just offer different dts files, one for each board revision?

Something like:
mpc8313erdb-revA.dts
mpc8313erdb-revB.dts
mpc8313erdb-revC.dts

Richard
