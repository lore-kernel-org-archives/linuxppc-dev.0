Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8717DDF5A
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 01:38:18 +1000 (EST)
Message-Id: <108F19DB-702D-4FA9-A8A6-6239DFD30043@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20080916095741.9992.96106.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v5 0/2] powerpc: Board support for GE Fanuc SBC610
Date: Tue, 16 Sep 2008 09:54:59 -0500
References: <18638.50702.962371.862911@cargo.ozlabs.ibm.com>
	<20080916095741.9992.96106.stgit@ubuntu8041.localdomain>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 16, 2008, at 4:57 AM, Martyn Welch wrote:

> The following series implements basic board support for GE Fanuc's  
> SBC610, a
> 6U single board computer, based on Freescale's MPC8641D.
>
> This series provides basic functionality:
> - The board can boot with a serial console.
> - Ethernet works, though the phys are polled.
> - The PCI bus is scanned and sata functions.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>

what changed in v5?

- k
