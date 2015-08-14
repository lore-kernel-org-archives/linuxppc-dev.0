Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB82F1A0779
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 19:00:34 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 14 Aug 2015 19:00:33 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 701202BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 19:00:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E90KFB65339632
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 19:00:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E8xtGE000855
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 18:59:56 +1000
Message-ID: <55CDADF1.5050308@linux.vnet.ibm.com>
Date: Fri, 14 Aug 2015 14:29:29 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
CC: mikey@neuling.org, Segher Boessenkool <segher@kernel.crashing.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc: Add an inline function to update POWER8 HID0
References: <20150805065400.GA14701@in.ibm.com>
 <1438758511-918-1-git-send-email-ego@linux.vnet.ibm.com>
In-Reply-To: <1438758511-918-1-git-send-email-ego@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/05/2015 12:38 PM, Gautham R. Shenoy wrote:
> Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
> prescribes that updates to HID0 be preceded by a SYNC instruction and
> followed by an ISYNC instruction (Page 91).
> 
> Create an inline function name update_power8_hid0() which follows this
> recipe and invoke it from the static split core path.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Reviewed-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
