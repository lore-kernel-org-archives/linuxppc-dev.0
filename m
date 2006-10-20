Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 1D1FA67B6D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 20:00:44 +1000 (EST)
Date: Fri, 20 Oct 2006 12:00:10 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH] enable RTAS /proc for PowerPC/CHRP platform
Message-ID: <20061020100010.GA5867@aepfle.de>
References: <1161300942.10524.64.camel@localhost.localdomain>
	<20061020054434.GC3277@aepfle.de>
	<1161323797.10524.150.camel@localhost.localdomain>
	<20061020062431.GB14390@powerlinux.fr>
	<20061020064456.GA3946@aepfle.de>
	<20061020065849.GA17286@powerlinux.fr>
	<20061020072037.GA4355@aepfle.de>
	<20061020073745.GC17286@powerlinux.fr>
	<D22CDFD1-C5A7-422E-9052-FFB5480AE06F@kernel.crashing.org>
	<20061020085207.GA21103@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061020085207.GA21103@powerlinux.fr>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, Sven Luther <sl@bplan-gmbh.de>,
	tilmann@bitterberg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 20, Sven Luther wrote:

> Yeah, that makes sense. Will the device-tree move to /sys some day ? What

Moving /proc/device-tree would be an insane change.
