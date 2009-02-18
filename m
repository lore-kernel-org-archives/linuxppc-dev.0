Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA4F8DDDF9
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 03:49:15 +1100 (EST)
Message-Id: <D999D051-E5A2-4915-893D-E3384EC312A4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ira Snyder <iws@ovro.caltech.edu>
In-Reply-To: <20090217222425.GA18801@ovro.caltech.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [RFC v1] virtio: add virtio-over-PCI driver
Date: Wed, 18 Feb 2009 10:47:05 -0600
References: <20090217222425.GA18801@ovro.caltech.edu>
Cc: Arnd Bergmann <arnd@arndb.de>, Jan-Bernd Themann <THEMANN@de.ibm.com>,
	netdev@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 17, 2009, at 4:24 PM, Ira Snyder wrote:

>
> Documentation/virtio-over-PCI.txt     |   61 ++
> arch/powerpc/boot/dts/mpc834x_mds.dts |    7 +

we'll have to review the .dts and expect a documentation update for  
the node.  But that's pretty minor at this point.

> drivers/virtio/Kconfig                |   22 +
> drivers/virtio/Makefile               |    2 +
> drivers/virtio/vop.h                  |  119 ++
> drivers/virtio/vop_fsl.c              | 1911 ++++++++++++++++++++++++ 
> +++++++++

make this vop_fsl_mpc83xx.c or something along those lines.

>
> drivers/virtio/vop_host.c             | 1028 ++++++++++++++++++
> drivers/virtio/vop_hw.h               |   80 ++
> 8 files changed, 3230 insertions(+), 0 deletions(-)
> create mode 100644 Documentation/virtio-over-PCI.txt
> create mode 100644 drivers/virtio/vop.h
> create mode 100644 drivers/virtio/vop_fsl.c
> create mode 100644 drivers/virtio/vop_host.c
> create mode 100644 drivers/virtio/vop_hw.h

- k
