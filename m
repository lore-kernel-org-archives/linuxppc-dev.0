Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0E78DDE9A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 23:15:44 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A0830B08-2A3A-4BC1-BAAB-82D1C1D3CB7E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: still using stabs debug format?
Date: Fri, 17 Aug 2007 08:17:24 -0500
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Cc: Ed Swarthout <Ed.Swarthout@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is anyone really still using the stabs format for kernel debug?

can we kill off the .stabs references?

- k
