Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D6DA6DDFE2
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:37:22 +1000 (EST)
Date: Mon, 28 Apr 2008 17:37:35 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [RFC, PATCH 0/7] Power management patches from Scott Wood plus
	MPC8241 Linkstation
Message-ID: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linux-pm@lists.linux-foundation.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all

as replies to this email I'm going to post a respin of the last version 
from December 2007 of Scott's patches plus my patch for Linkstation 
standby.

Scott, I upgraded your patches, please, verify, that they still function. 
I added my Sof's as I'm now forwarding them, I believe, this is correct. I 
tried to preserve original CC lists.

<remark>
Knowing how important power management on ARM systems is I'm a bit 
confused about why this is not the case on _embedded_ powerpc.
</remark>

Thanks
Guennadi
---
Guennadi Liakhovetski
