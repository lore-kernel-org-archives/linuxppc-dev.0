Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C70D1A0AFE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 07:35:27 +1100 (AEDT)
Date: Thu, 19 Mar 2015 21:35:22 +0100
From: Torsten Duwe <duwe@lst.de>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v0 0/4] ppc64le: dynamic ftrace and kgraft support
Message-ID: <20150319203522.GA19524@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here's an initial version of dynamic ftrace for ABIv2 (ppc64le),
the code maturity is somewhere between proof of concept and pre-alpha.
I have split it into 4 parts, for ftrace and kgraft, a configuration
enablement and the actual code, respectively.
Please have a look and tell me whether this is the way to go.

	Torsten
