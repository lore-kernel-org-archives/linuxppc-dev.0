Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9A121007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Nov 2010 13:44:27 +1100 (EST)
Subject: Re: [PATCH 3/5] fpga: add basic CARMA board support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
In-Reply-To: <1283964082-30133-4-git-send-email-iws@ovro.caltech.edu>
References: <1283964082-30133-1-git-send-email-iws@ovro.caltech.edu>
	<1283964082-30133-4-git-send-email-iws@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Nov 2010 11:38:14 +1100
Message-ID: <1290991094.32570.213.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-08 at 09:41 -0700, Ira W. Snyder wrote:
> This adds basic support for the system controller FPGA on the OVRO CARMA
> board. This patch only adds infrastructure that will be used by later
> drivers.

Oh and another comment ...

I'm not sure about drivers/fpga ... in the end, one would expect such a
directory to contain stuff to manipulate FPGAs in the sense of
downloading bitfiles, instanciating devices (device-tree manipulation ?)
etc...

>From what I see in your code, the fact that these are FPGAs is almost
irrelevant, you are providing support for "carma" devices, and such are
no different than some other platform device, they just happen to be
implemented as FPGAs. Or am I missing something ?

Cheers,
Ben.
