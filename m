Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FADF1A02A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 17:54:44 +1000 (EST)
Message-ID: <1403078080.32307.6.camel@concordia>
Subject: Re: Boot failure in Power7 pSeries
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Date: Wed, 18 Jun 2014 17:54:40 +1000
In-Reply-To: <53A1070C.50106@linux.vnet.ibm.com>
References: <53A00E2B.8030903@linux.vnet.ibm.com>
 <53A1070C.50106@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-18 at 11:27 +0800, Mike Qiu wrote:
> Anyone has a idea on this issue?

Did it ever work? If so which kernel version?

Can you attach your actual .config.

You could try building without CONFIG_PPC_POWERNV.

cheers
