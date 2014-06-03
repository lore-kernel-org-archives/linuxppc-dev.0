Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADA281A0845
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 17:52:41 +1000 (EST)
Message-ID: <1401781939.3247.11.camel@pasglop>
Subject: Re: [PATCH 4/4] powerpc/eeh: Avoid event on passed PE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Tue, 03 Jun 2014 17:52:19 +1000
In-Reply-To: <5C4E374F-0BE1-4BE3-991C-E6BD64E90E6A@suse.de>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400574612-19411-5-git-send-email-gwshan@linux.vnet.ibm.com>
 <537B3B97.3020100@suse.de> <20140603055415.GA24370@iris.ozlabs.ibm.com>
 <5C4E374F-0BE1-4BE3-991C-E6BD64E90E6A@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-06-03 at 09:45 +0200, Alexander Graf wrote:
> For EEH it could as well be a dumb eventfd - really just a side
> channel that can tell user space that something happened
> asynchronously :).

Which the host kernel may have no way to detect without actively poking
at the device (fences in powernv or anything in PAPR host) and the only
user of this for now has no use for.

I insist don't bother.

Cheers,
Ben.
