Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B368CDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 00:20:38 +1000 (EST)
Message-ID: <46B0972C.3020000@ru.mvista.com>
Date: Wed, 01 Aug 2007 18:22:36 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
	<4574197A.2020204@ru.mvista.com>
	<4FC2EBCF-C927-435A-9BE3-E4403AFC042D@kernel.crashing.org>
	<45741DDE.4080509@ru.mvista.com>
	<20061204132124.4f7c50a9@localhost.localdomain>
	<52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
In-Reply-To: <52F5B831-5B40-4D40-A77F-4D7484692CAE@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
	Alan <alan@lxorguk.ukuu.org.uk>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>> setup-pci is for SFF8038i devices. It therefore knows that for  assigned
>> resources they must be I/O. It also assumes that zero is not a  valid I/O
>> port just like zero is not a valid IRQ. Stick a real IDE resource  at 
>> zero and drivers/ide can't cope.

> But 0 _is_ a valid PCI I/O address.  Do we now have to start

    I wasn't in PCI 2.1 (later the corresponding passage have disppeared).

> using "virtual I/O addresses", analogue to the IRQ situation,
> or can these bad assumptions be fixed instead?

> Segher

WBR, Sergei
