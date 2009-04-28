Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54E28DDDA9
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 12:07:04 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n3S270DK012979
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 19:07:01 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n3S26xCh014678
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 21:07:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] fsldma: use PCI Read Multiple command
Date: Tue, 28 Apr 2009 10:06:58 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208928CACB@zch01exm21.fsl.freescale.net>
In-Reply-To: <49F60F1C.3050300@ovro.caltech.edu>
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>	<49F608B7.9080409@ovro.caltech.edu>	<49F60A3A.4060402@freescale.com>	<49F60BF8.8040404@ovro.caltech.edu>
	<46B638E2-885C-4281-81EA-CB685264E143@kernel.crashing.org>
	<49F60EC9.2050501@ovro.caltech.edu>
	<49F60F1C.3050300@ovro.caltech.edu>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: Tabi Timur-B04825 <timur@freescale.com>, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, Ira Snyder <iws@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >> You can mark the pci inbound window on the 83xx as=20
> >> non-prefetchable(assuming 83xx is host). On a x86 host
> >> I doubt there is any easy way to get non-prefetchable memory.

> One more note; we don't have access to a host-mode MPC8349EA,
> our boards are all targets.

Actually we also can use the inbound window(w/wo prefetchable)
in the agent mode. It doesn't care if it is host or agent.
