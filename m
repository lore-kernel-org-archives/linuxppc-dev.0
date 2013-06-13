Return-Path: <benh@au1.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D3062C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 14:42:51 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 13 Jun 2013 14:31:40 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AD9992CE8044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 14:42:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5D4gcDb25166064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 14:42:38 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5D4gk22027553
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 14:42:46 +1000
Message-ID: <1371098537.5555.0.camel@pasglop>
Subject: Re: [PATCH 15/27] powerpc/eeh: I/O chip EEH state retrieval
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 13 Jun 2013 14:42:17 +1000
In-Reply-To: <20130613042615.GA4045@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-16-git-send-email-shangw@linux.vnet.ibm.com>
 <1370936224.8250.93.camel@pasglop> <20130612033203.GA10000@shangw.(null)>
 <1371010765.8250.173.camel@pasglop> <20130613042615.GA4045@shangw.(null)>
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

On Thu, 2013-06-13 at 12:26 +0800, Gavin Shan wrote:
> So the answer is we can do it by makeing the assumption that f/w won't
> return valid delay and we're going to use default value (1 second) for
> guest on powernv or phyp, or we keep the delay here.

Ok, at the very least then change the name to "unavailable_delay" or
something explicit like that then :-)

BTW. I've already applied patches 1 and 2 to my tree, you don't have to
resend those. They'll show up today or tomorrow when I push my next
branch out.

Cheers,
Ben.
