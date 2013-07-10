Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 66CCA2C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 20:39:24 +1000 (EST)
Message-ID: <1373452753.19894.19.camel@pasglop>
Subject: Re: [PATCH 8/8] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Wed, 10 Jul 2013 20:39:13 +1000
In-Reply-To: <778C7C81-5F7F-4E21-8B72-92F336002F9E@suse.de>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
 <1373123227-22969-9-git-send-email-aik@ozlabs.ru>
 <51DC4923.5010501@suse.de> <51DC9CDA.3070906@ozlabs.ru>
 <778C7C81-5F7F-4E21-8B72-92F336002F9E@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-10 at 12:33 +0200, Alexander Graf wrote:
> 
> It's not exactly obvious that you're calling it with writing == 1 :).
> Can you create a new local variable "is_write" in the calling
> function, set that to 1 before the call to get_user_pages_fast and
> pass it in instead of the 1? The compiler should easily optimize all
> of that away, but it makes the code by far easier to read.

Ugh ?

Nobody else does that .... (look at futex :-)

Ben.
