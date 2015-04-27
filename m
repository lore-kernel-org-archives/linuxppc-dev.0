Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A59D01A08C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 19:57:45 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EE8D114007D
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 19:57:44 +1000 (AEST)
Message-ID: <1430128646.16571.112.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 2/4] pci: Support 64-bit address translation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Huth <thuth@redhat.com>
Date: Mon, 27 Apr 2015 19:57:26 +1000
In-Reply-To: <20150427113229.294bf50d@thh440s>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1430121753-24818-3-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150427113229.294bf50d@thh440s>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, Adrian Reber <adrian@lisas.de>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-04-27 at 11:32 +0200, Thomas Huth wrote:
> Anyway, I think we can fix that up as soon as somebody tries to run
> the
> js2x code again (I still have a YDL PowerStation at home somewhere,
> maybe I will have enough spare time to reactivate it one day).
> 
> And since your changes itself looks fine to me:

Another thing we could do with the new IPMI stack floating around would
be to do a js2x model in qemu :-) Shouldn't be too hard .... I've
promised Alex Graf I would do a proper U4 model one day ... :-)

Cheers,
Ben.
