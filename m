Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DFD1A017B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 20:12:35 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A4DCA140082
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 20:12:34 +1000 (AEST)
Date: Mon, 27 Apr 2015 12:12:05 +0200
From: Thomas Huth <thuth@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/4] pci: Support 64-bit address translation
Message-ID: <20150427121205.413881d0@thh440s>
In-Reply-To: <1430128646.16571.112.camel@kernel.crashing.org>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1430121753-24818-3-git-send-email-nikunj@linux.vnet.ibm.com>
 <20150427113229.294bf50d@thh440s>
 <1430128646.16571.112.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 27 Apr 2015 19:57:26 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Mon, 2015-04-27 at 11:32 +0200, Thomas Huth wrote:
> > Anyway, I think we can fix that up as soon as somebody tries to run
> > the
> > js2x code again (I still have a YDL PowerStation at home somewhere,
> > maybe I will have enough spare time to reactivate it one day).
> > 
> > And since your changes itself looks fine to me:
> 
> Another thing we could do with the new IPMI stack floating around would
> be to do a js2x model in qemu :-) Shouldn't be too hard .... I've
> promised Alex Graf I would do a proper U4 model one day ... :-)

That would be very cool, indeed!

 Thomas
