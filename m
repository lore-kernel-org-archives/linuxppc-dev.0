Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F7EB1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 06:44:39 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 15 Jan 2016 12:44:37 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BA6A4C40003
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 12:32:44 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0FJiYut30212134
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 12:44:34 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0FJiXHO032589
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 12:44:34 -0700
Date: Fri, 15 Jan 2016 11:44:00 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/perf: Export Power8 generic and cache events
 to sysfs
Message-ID: <20160115194400.GA16425@us.ibm.com>
References: <1452552926-17494-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1452552926-17494-2-git-send-email-sukadev@linux.vnet.ibm.com>
 <56978D36.5040005@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56978D36.5040005@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
> > +enum {
> > +#include "power8-events-list.h"
> > +};
> >  
> 
> IIUC we dont use this enum as a index to
> some array, so can we do something like this?

Possibly, but its already a macro soup and we would add another
layer of indirection? I agree though that the #define and #undefs
are not intuitive. Since it is only a few entries for Power8, was
keeping it consistent with Power7.

Sukadev
