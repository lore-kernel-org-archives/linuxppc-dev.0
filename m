Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 571EAB700B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2012 06:45:43 +1000 (EST)
Subject: Re: [PATCH] USB: FHCI: Reusing the QUICC Engine USB Controller
 registers struct from immap_qe.h.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAF=5bWf_fzj2ZV8dLJFdffqQ7J5spepBi3qp7NN8SqUfkm1mMQ@mail.gmail.com>
Date: Tue, 19 Jun 2012 15:45:43 -0500
Message-Id: <8E8E8EE9-1231-47D2-9E94-C6F5130A3C5B@kernel.crashing.org>
References: <CAF=5bWf_fzj2ZV8dLJFdffqQ7J5spepBi3qp7NN8SqUfkm1mMQ@mail.gmail.com>
To: guilherme.maciel.ferreira@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 19, 2012, at 8:12 AM, Guilherme Maciel Ferreira wrote:

> The struct fhci_regs (in fhci.h) is basically a redefinition
> of the struct qe_usb_ctlr (in immap_qe.h). The later struct is
> preferrable once it uses the registers names found at the
> Freescale's QUICC Engine manual. Thus it is easier to map the
> driver to the manual.
>=20
> Also, the FHCI driver uses the USB controller registers, so
> the name qe_usb_ctlr maps better to the hardware than fhci_regs.
>=20
> Signed-off-by: Guilherme Maciel Ferreira =
<guilherme.maciel.ferreira@gmail.com>
> ---
> drivers/usb/host/fhci-dbg.c   |   12 ++++++------
> drivers/usb/host/fhci-hcd.c   |   32 ++++++++++++++++----------------
> drivers/usb/host/fhci-hub.c   |   16 ++++++++--------
> drivers/usb/host/fhci-sched.c |   30 +++++++++++++++---------------
> drivers/usb/host/fhci-tds.c   |   14 +++++++-------
> drivers/usb/host/fhci.h       |   22 ++--------------------
> 6 files changed, 54 insertions(+), 72 deletions(-)

This should be sent to the USB maintainers.

- k=
