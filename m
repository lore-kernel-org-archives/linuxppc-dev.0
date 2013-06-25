Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2175E2C0299
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 20:56:22 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 16:20:18 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5DA3A3940058
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 16:26:15 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5PAuCps16253106
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 16:26:12 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5PAuDpQ014120
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 10:56:14 GMT
Message-ID: <51C9772E.5050900@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 16:25:42 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/8] powerpc/perf: Check that events only include valid
 bits on Power8
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2013 04:58 PM, Michael Ellerman wrote:
> A mistake we have made in the past is that we pull out the fields we
> need from the event code, but don't check that there are no unknown bits
> set. This means that we can't ever assign meaning to those unknown bits
> in future.
> 
> Although we have once again failed to do this at release, it is still
> early days for Power8 so I think we can still slip this in and get away
> with it.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
