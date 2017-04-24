Return-Path: <srs0=pwla=4a=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBGQC38K2zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 16:19:15 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wBGQC2NC8z8t3y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 16:19:15 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wBGQB0kLCz9s7x
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2017 16:19:13 +1000 (AEST)
Message-ID: <1493014709.25766.206.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 04/11] VAS: Define vas_init() and vas_exit()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 24 Apr 2017 16:18:29 +1000
In-Reply-To: <1490937224-29149-5-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490937224-29149-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Thu, 2017-03-30 at 22:13 -0700, Sukadev Bhattiprolu wrote:
> +config VAS
> +       tristate "IBM Virtual Accelerator Switchboard (VAS)"

CONFIG_IBM_VAS or PPC_VAS ... too high risk of collision otherwise

Ben.
