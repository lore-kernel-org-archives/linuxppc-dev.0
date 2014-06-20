Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A324D1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 09:16:25 +1000 (EST)
Message-ID: <1403306175.4587.68.camel@pasglop>
Subject: Re: [PATCH] vfio: Fix endianness handling for emulated BARs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Sat, 21 Jun 2014 09:16:15 +1000
In-Reply-To: <53A441D3.8010602@ozlabs.ru>
References: <1403091391-31780-1-git-send-email-aik@ozlabs.ru>
 <1403116512.3707.175.camel@ul30vt.home> <53A233E9.6030006@ozlabs.ru>
 <53A241F6.9010307@ozlabs.ru> <53A25D74.5000804@ozlabs.ru>
 <1403234514.3707.278.camel@ul30vt.home> <53A441D3.8010602@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2014-06-21 at 00:14 +1000, Alexey Kardashevskiy wrote:

> We can still use __raw_writel&co, would that be ok?

No unless you understand precisely what kind of memory barriers each
platform require for these.

Cheers,
Ben.
