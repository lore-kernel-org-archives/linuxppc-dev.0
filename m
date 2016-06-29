Return-Path: <darren@stevens-zone.net>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfwK248SHzDqyS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 07:09:10 +1000 (AEST)
From: Darren Stevens <darren@stevens-zone.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org, Pat Wall <pjwall@mac.com>,
 matthew@a-eon.com, aperez@alexperez.com, R.T.Dickinson <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Wed, 29 Jun 2016 20:52:26 +0100 (BST)
Message-ID: <4867f5f0535.f0a9124@auth.smtp.1and1.co.uk>
In-Reply-To: <1466981401.20278.29.camel@kernel.crashing.org>
References: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
 <1466981401.20278.29.camel@kernel.crashing.org>
Subject: Re: Proposed: Patch to fix boot on PA6T
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Benjamin

On 27/06/2016, Benjamin Herrenschmidt wrote:
> Tell me more, when is that mapping done ? I'm changing things so that
> platform probe is called much later so that might have an impact.
>
> What consumes pci_io_base before it's been initialized ?

pas_pci_init() is the culprit. Following on from Aneesh's suggestion an
improved patch will follow shoertly.

Regards
Darren
