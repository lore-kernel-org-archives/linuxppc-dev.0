Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2FFC1A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 14:55:39 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Fri, 14 Aug 2015 14:55:38 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0776B2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 14:55:34 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E4tKIn1245558
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 14:55:28 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E4t1g3018420
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 14:55:01 +1000
Date: Fri, 14 Aug 2015 14:54:34 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>, mikey@neuling.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc: Add an inline function to update POWER8 HID0
Message-ID: <20150814045434.GA13544@tungsten.ozlabs.ibm.com>
References: <20150805065400.GA14701@in.ibm.com>
 <1438758511-918-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438758511-918-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 05, 2015 at 12:38:31PM +0530, Gautham R. Shenoy wrote:
> Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
> prescribes that updates to HID0 be preceded by a SYNC instruction and
> followed by an ISYNC instruction (Page 91).
> 
> Create an inline function name update_power8_hid0() which follows this
> recipe and invoke it from the static split core path.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Hi Gautham,

I've tested this on a Power 8 machine and verified that it is able to change
split modes and that when doing so the new code is used.

Reviewed-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
Tested-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
