Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 867D51A0924
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 07:47:16 +1000 (AEST)
Message-ID: <1435700814.1475.15.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 40/42] drivers/of: Allow to specify root node in
 of_fdt_unflatten_tree()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@linaro.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 bhelgaas@google.com, aik@ozlabs.ru, panto@antoniou-consulting.com,
 robherring2@gmail.com
Date: Wed, 01 Jul 2015 07:46:54 +1000
In-Reply-To: <20150630180652.198E2C4063C@trevor.secretlab.ca>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-41-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150630180652.198E2C4063C@trevor.secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-06-30 at 19:06 +0100, Grant Likely wrote:
> It may be time to dump the special allocation of fdt.c entirely and
> treat all nodes the same way, with name and properties all allocated
> with normal kmallocs.... Investigation is needed to figure out if this
> is feasible.

kmalloc isn't available early enough

Cheers,
Ben.
