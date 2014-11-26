Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E273C1A089D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Nov 2014 10:44:25 +1100 (AEDT)
Message-ID: <1417045452.5089.69.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 3/6] pseries: Create new device hotplug entry point
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 27 Nov 2014 10:44:12 +1100
In-Reply-To: <546A6DEE.8080708@linux.vnet.ibm.com>
References: <546A6C23.1080800@linux.vnet.ibm.com>
 <546A6DEE.8080708@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-17 at 15:51 -0600, Nathan Fontenot wrote:
> 
> For PowerVM systems, this patch creates the /sys/kernel/dlpar file that rtas
> hotplug events can be written to by drmgr and passed to the common entry point.
> There is no chance of updating how we receive hotplug requests on PowerVM
> systems.

I'm not convinced this is the right place for that file, might be worth asking
Greg KH what he thinks here.

Cheers,
Ben.
