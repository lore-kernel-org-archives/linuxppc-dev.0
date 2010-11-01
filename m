Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A01241007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 02:58:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RapidIO: MC Exception when enumerating peer to peer connection
Date: Mon, 1 Nov 2010 08:58:08 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552014B9D48@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTikhcOMexRBVthK8Xr8VTNvDmiUDvWG+QbyzWc38@mail.gmail.com>
References: <AANLkTimS-sfqONuSJNPJy7OxO_U81qtDHe2JeioLDNVs@mail.gmail.com><4CCA9207.8050506@neli.hopto.org>
	<AANLkTikhcOMexRBVthK8Xr8VTNvDmiUDvWG+QbyzWc38@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Thomas Taranowski" <tom@baringforge.com>,
	"Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Taranowski wrote:
> Yes, I tried pretty much all combinations of boot order, but I believe
> the preferred approach is to boot the agents first, then the host
> according to my freescale documentation.  My problem was that all
> three devices had the same device id.  Once I programmed them with
> different device id's via the alternate device id register I could
> finally get doorbell messages across with the jtag.
=20
In the current fsl_rio implementation initialization enables ACCEPT_ALL
mode for the port therefore you should not have problems caused by
initial destID value. Based on your post about multiport support I think
you are close to find a source of the problem.

Are you using any switches in your setup or this is pure board-to-board
configuration?

Alex.
