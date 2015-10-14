Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B312F1A0270
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:39:09 +1100 (AEDT)
Message-ID: <1444815549.1843.4.camel@ellerman.id.au>
Subject: Re: [PATCH v3 1/2] powerpc/xmon: Paged output for paca display
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, khandual@linux.vnet.ibm.com
Date: Wed, 14 Oct 2015 20:39:09 +1100
In-Reply-To: <77516a018529fe23ca466db2ea513f7f03d820ec.1444265419.git.sam.bobroff@au1.ibm.com>
References: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
 <77516a018529fe23ca466db2ea513f7f03d820ec.1444265419.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-08 at 11:50 +1100, Sam Bobroff wrote:
> The paca display is already more than 24 lines, which can be problematic
> if you have an old school 80x24 terminal, or more likely you are on a
> virtual terminal which does not scroll for whatever reason.
> 
> This patch adds a new command ".", which takes a single (hex) numeric
> argument: lines per page. It will cause the output of "dp" and "dpa"
> to be broken into pages, if necessary.
> 
> Sample output:
> 
> 0:mon> .10

So what about making it "#" rather than "." ?

cheers
