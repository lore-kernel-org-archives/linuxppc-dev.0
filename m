Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id B027FDDE27
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 10:13:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: locking problem in sata_sil24?
Date: Mon, 3 Mar 2008 17:13:31 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0410A5BA@ismail.innsys.innovsys.com>
In-Reply-To: <1204585095.21545.37.camel@pasglop>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
	<1204583866.21545.31.camel@pasglop>
	<DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com>
	<1204585095.21545.37.camel@pasglop>
From: "Rune Torgersen" <runet@innovsys.com>
To: <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Benjamin Herrenschmidt
> In fact, I remember working on 64 bits lockdep, based on patches from
> Johannes, but I didn't do 32 bits. I think somebody worked on it, but
> now I can't find the patches...

http://patchwork.ozlabs.org/linuxppc/patch?id=3D16652

> Whoever did it can bounce them back to me ? I intend to do some more
> work on this soon.
