Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 80FD167BFD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 00:42:53 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
Date: Tue, 21 Nov 2006 14:42:30 +0100
References: <4554DACB.8060809@am.sony.com>
	<17762.59947.937875.546225@cargo.ozlabs.ibm.com>
	<20061121132253.GA17530@lst.de>
In-Reply-To: <20061121132253.GA17530@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611211442.31667.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Olof Johansson <olof@lixom.net>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 21 November 2006 14:22, Christoph Hellwig wrote:
> The whole port is hypervisor-specific. =A0It should be called ps3hv or
> sonyhv (in case the plan for more hardware that's crippled by this
> hypervisor)=20

The hypervisor has a name, it's called 'lv1', and the port already
uses that identifier for the low-level interfaces.
If the platform is named after the hypervisor, we should not make up
a new name but use the one that is already there.

> ps3 should be left for a bare metal port that people may or may not do=20

If there will ever be a native port, that will not need its platform
directory but can simply go into into common platforms/cell/ and sysdev
directories, with a small file for the ppc_md instance. All the interesting
files (page table, iommu, interrupt handling) would be shared with native
ports to different hardware.

	Arnd <><
