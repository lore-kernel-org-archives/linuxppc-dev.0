Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5785767A3A
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 01:11:20 +1100 (EST)
Date: Mon, 4 Dec 2006 14:15:12 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
Message-ID: <20061204141512.0eba89f9@localhost.localdomain>
In-Reply-To: <52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 Dec 2006 14:25:04 +0100
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> But 0 _is_ a valid PCI I/O address.  Do we now have to start
> using "virtual I/O addresses", analogue to the IRQ situation,
> or can these bad assumptions be fixed instead?

Send patches to Bartlomiej now he is back in circulation.

Alan
