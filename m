Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6469CDDE9B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 08:14:16 +1000 (EST)
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <04ce93c63dfaa543b4068d448c8115d8@kernel.crashing.org>
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
	<46B0972C.3020000@ru.mvista.com>
	<20070801165140.3e176cd1@the-village.bc.nu>
	<04ce93c63dfaa543b4068d448c8115d8@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 08:14:06 +1000
Message-Id: <1186438446.938.81.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-08-06 at 20:04 +0200, Segher Boessenkool wrote:
> That's of course the smarter choice, _if_ we have a choice at
> all -- on PowerPC, the PCI setup on certain platforms is done
> by the firmware (and we don't want to mess with it for various
> reasons), and some _do_ map PCI legacy I/O at 0.
> 
> Not in this case though, so let's just ignore that possibility
> until it hits us in the face :-) 

Agreed. We can always try to remap just that device if it becomes an
issue.

Ben.
