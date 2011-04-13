Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2011 09:05:12 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc: Add an ePAPR compliant boot wrapper
Message-ID: <20110413130512.GD26874@zod.rchland.ibm.com>
References: <34e3e03a96888bc8c20013aa65712123ccf94649.1302676893.git.michael@ellerman.id.au>
	<732a8ac3a24023f021908d03bd84b76638f381f1.1302676893.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <732a8ac3a24023f021908d03bd84b76638f381f1.1302676893.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2011 at 04:38:56PM +1000, Michael Ellerman wrote:
>+++ b/arch/powerpc/boot/epapr.c
>@@ -0,0 +1,69 @@
>+/*
>+ * Bootwrapper for ePAPR compliant firmwares

Out of curiosity, do we have a list of the ePAPR compliant firmwares (if
any)?

>+ *
>+ * Copyright 2010 David Gibson <david@gibson.dropbear.id.au>, IBM Corporation.
>+ *
>+ * Based on earlier bootwrappers by:
>+ * (c) Benjamin Herrenschmidt <benh@kernel.crashing.org>, IBM Corp,\
>+ *   and
>+ * Scott Wood <scottwood@freescale.com>
>+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
>+ *
>+ * This program is free software; you can redistribute it and/or modify it
>+ * under the terms of the GNU General Public License version 2 as published
>+ * by the Free Software Foundation.
>+ */
>+
>+#include "ops.h"
>+#include "stdio.h"
>+#include "planetcore.h"
>+#include "dcr.h"
>+#include "4xx.h"
>+#include "io.h"

Do you need planetcore, dcr, and 4xx.h included here?  I don't see
anything used that would require them.

josh
