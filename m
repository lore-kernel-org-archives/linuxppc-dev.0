Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5339E2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2012 10:56:32 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 7 Sep 2012 18:56:29 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 08D2119D8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 18:55:56 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q880ttB6214150
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 18:55:55 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q880ttPa032673
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 18:55:55 -0600
Date: Fri, 7 Sep 2012 17:55:49 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] powerpc/e6500: TLB miss handler with hardware
 tablewalk support
Message-ID: <20120908005549.GA5451@linux.vnet.ibm.com>
References: <20120614234101.GB17147@tyr.buserror.net>
 <1346992880.2385.51.camel@pasglop> <504A4C3D.3040709@freescale.com>
 <504A7CBC.80803@freescale.com> <1347061804.2385.58.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347061804.2385.58.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.09.2012 [09:50:04 +1000], Benjamin Herrenschmidt wrote:
<snip>
> BTW. On another note, can you pickup Ananth series for larger address

I think you mean Aneesh here? Just to help Scott find the thread.

Thanks,
Nish

> space (minus the one patch that breaks the BookE build, it shouldn't
> matter) and see if there's any runtime issue on BookE 64 ? (And whether
> the larger address space actually works for you too, using something
> like high up mmap tests)
> 
> Cheers,
> Ben.
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
