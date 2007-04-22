Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 89DBCDDEEF
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 05:11:20 +1000 (EST)
Date: Sun, 22 Apr 2007 14:30:18 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 7/7] MPIC MSI backend
Message-ID: <20070422193017.GA27048@lixom.net>
References: <20070419073556.73A6BDDE4A@ozlabs.org>
	<e4520bd4be50f2884003a9421863627c@bga.com>
	<ca8197808a747b83c14461f6fec375db@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca8197808a747b83c14461f6fec375db@kernel.crashing.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 22, 2007 at 09:06:15AM +0200, Segher Boessenkool wrote:

> mpic_htmsi deals with MSIs that come in over hypertransport
> to the MPIC on CPC925/CPC945; this has nothing to
> do with HT APICs.

Maybe it should be named mpic_cpc9x5msi instead?


-Olof
