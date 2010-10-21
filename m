Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D1A5B70D1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Oct 2010 20:30:03 +1100 (EST)
Date: Thu, 21 Oct 2010 10:06:42 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH V5 1/9] Add Synopsys DesignWare HS USB OTG Control and
	Status Register (CSR).
Message-ID: <20101021100642.6c6fbb0d@lxorguk.ukuu.org.uk>
In-Reply-To: <1287621773567-git-send-email-fchen@apm.com>
References: <12876217721253-git-send-email-fchen@apm.com>
	<1287621773567-git-send-email-fchen@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +#if defined(CONFIG_DWC_OTG_REG_LE)

Is it really necessary to have everything in the header twice rather than
using endian switches in the I/O ?

Also with the code in that form how do you build a single copy of the
driver that runs on platforms which may have one or the other endian

Finally - we have defines for bitfield direction - because the compiler
has a lot of latitude in which way around it packs bitfields.
