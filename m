Return-Path: <sam.bobroff@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08DA41A039B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 09:25:51 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C4AD1140DB1
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 09:25:50 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Thu, 15 Oct 2015 08:25:50 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 89BC62BB004D
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 09:25:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9EMPPAx17629410
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 09:25:33 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9EMPD0h001896
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 09:25:13 +1100
Date: Thu, 15 Oct 2015 09:24:38 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH v3 1/2] powerpc/xmon: Paged output for paca display
Message-ID: <20151014222438.GA1900@tungsten.ozlabs.ibm.com>
References: <cover.1444265419.git.sam.bobroff@au1.ibm.com>
 <77516a018529fe23ca466db2ea513f7f03d820ec.1444265419.git.sam.bobroff@au1.ibm.com>
 <1444815549.1843.4.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444815549.1843.4.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2015 at 08:39:09PM +1100, Michael Ellerman wrote:
> On Thu, 2015-10-08 at 11:50 +1100, Sam Bobroff wrote:
> > The paca display is already more than 24 lines, which can be problematic
> > if you have an old school 80x24 terminal, or more likely you are on a
> > virtual terminal which does not scroll for whatever reason.
> > 
> > This patch adds a new command ".", which takes a single (hex) numeric
> > argument: lines per page. It will cause the output of "dp" and "dpa"
> > to be broken into pages, if necessary.
> > 
> > Sample output:
> > 
> > 0:mon> .10
> 
> So what about making it "#" rather than "." ?
> 
> cheers

Sure, although we'll have to do a better job than the other commands in the help text ;-)
(They use "#" to indicate a hex number and "##" is just going to be confusing.)

Do you want me to respin? (I'm happy for you to just adjust the patch.)

Cheers,
Sam.
