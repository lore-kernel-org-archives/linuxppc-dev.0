Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8E02E2C007A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 02:21:14 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 12 Jun 2013 23:50:24 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 5ADF03E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 23:50:03 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5D5oLw9117112
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 23:50:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5D5oKXm009757
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 23:50:20 -0600
Date: Thu, 13 Jun 2013 13:50:17 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH 15/27] powerpc/eeh: I/O chip EEH state retrieval
Message-ID: <20130613055017.GA17094@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-16-git-send-email-shangw@linux.vnet.ibm.com>
 <1370936224.8250.93.camel@pasglop>
 <20130612033203.GA10000@shangw.(null)>
 <1371010765.8250.173.camel@pasglop>
 <20130613042615.GA4045@shangw.(null)>
 <1371098537.5555.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371098537.5555.0.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 13, 2013 at 02:42:17PM +1000, Benjamin Herrenschmidt wrote:
>On Thu, 2013-06-13 at 12:26 +0800, Gavin Shan wrote:
>> So the answer is we can do it by makeing the assumption that f/w won't
>> return valid delay and we're going to use default value (1 second) for
>> guest on powernv or phyp, or we keep the delay here.
>
>Ok, at the very least then change the name to "unavailable_delay" or
>something explicit like that then :-)
>

Ok.

>BTW. I've already applied patches 1 and 2 to my tree, you don't have to
>resend those. They'll show up today or tomorrow when I push my next
>branch out.
>

Ok. Thanks, Ben.

Thanks,
Gavin
