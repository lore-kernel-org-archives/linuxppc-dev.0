Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63FF1B6EDF
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Dec 2009 00:41:53 +1100 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nAU9bJ8E031122
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 04:37:19 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAUDfmv3140322
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 08:41:49 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAUDfm1J016633
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Nov 2009 08:41:48 -0500
Date: Mon, 30 Nov 2009 08:41:45 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Curtis Wald <CWald@WatchGuardVideo.com>
Subject: Re: [PATCH] POWERPC 4xx: Fix PCI in AMCC 440EP Yosemite DTS
Message-ID: <20091130134145.GA2937@zod.rchland.ibm.com>
References: <13F6A75BE29CE44F801B912901C3EF27022A3993@wgv4.watchguardvideo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <13F6A75BE29CE44F801B912901C3EF27022A3993@wgv4.watchguardvideo.local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2009 at 11:36:40AM -0600, Curtis Wald wrote:
>Yosemite.dts stanza for PCI was copied from Bamboo which has four PCI
>slots; Yosemite only has one PCI slot which is mapped to
>IDSEL 12, ADDR 22, IRQ2 Vector 25, INTA.
>
>Signed-off-by: Curtis Wald <cwald@watchguardvideo.com>

Your patch looks correct (I think), but is very badly word wrapped and
whitespace damaged.  Could you resend?

josh
