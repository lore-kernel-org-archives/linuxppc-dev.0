Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83A301A03C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 17:51:54 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 00/19] Refactor PCI controller operations
Date: Tue, 07 Apr 2015 09:51:47 +0200
Message-ID: <2115022.icVaKFjuna@wuerfel>
In-Reply-To: <1427778057-9505-1-git-send-email-dja@axtens.net>
References: <1427778057-9505-1-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 31 March 2015 16:00:38 Daniel Axtens wrote:
> This patch set moves some PCI controller operations out of ppc_md and
> into a new pci_controller_ops struct.
> 
> This is desirable for systems with more than one type of PCI
> controller. In particular, it's intended that this new interface will
> be used by the CXL (aka CAPI) driver.
> 
> The design tries to balance a desire to avoid having yet another
> abstraction layer with a desire to make it easy for vendor kernels to
> pull in as little or as much as they are comfortable with.

I looked over the whole series again now, and with my previous concern
withdrawn, everything looks good to me. Nice work!

	Arnd
