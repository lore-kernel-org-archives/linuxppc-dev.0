Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sRBCs3qQSzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Sep 2016 19:54:17 +1000 (AEST)
Date: Sat, 3 Sep 2016 19:54:13 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/mm: Don't alias user region to other regions
 below PAGE_OFFSET
Message-ID: <20160903095413.GA868@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <87vayeqyo7.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vayeqyo7.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 02, 2016 at 05:52:16PM +0530, Aneesh Kumar K.V wrote:
> 
> Hi Paul,
> 
> Really nice catch. Was this found by code analysis or do we have any
> reported issue around this ?

I found it by code analysis.

I haven't been able to find any really bad consequence, beyond leaking
some information about kernel memory.  Can you find any worse
consequence?

Paul.
