Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0C211A0064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 06:35:12 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 22 Dec 2014 14:35:10 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 6F54C38C8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 14:35:07 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBMJZ7W323396548
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 19:35:07 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBMJZ6s2023482
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 14:35:07 -0500
Date: Mon, 22 Dec 2014 11:34:36 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 3/4] perf Documentation: add event parameters
Message-ID: <20141222193436.GB19784@us.ibm.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141222143943.GB29096@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222143943.GB29096@krava.brq.redhat.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:
| On Sun, Dec 21, 2014 at 11:49:26PM -0800, Sukadev Bhattiprolu wrote:
| > From: Cody P Schafer <cody@linux.vnet.ibm.com>
| > +		In the case of the last example, a value replacing "?" would
| > +		need to be provided by the user selecting the particular event.
| > +		This is referred to as "event parameterization". All
| > +		non-numerical values indicate an event parameter.
| 
| I see.. here's the glitch ;-) I thought we agreed on forcing '?'
| as the value for param events, not 'All non-numerical values'

Yes, it is currently more broad than needed, but it is not really
user input - we are just parsing sysfs entries that developer specified
in the kernel. If necessary, we can tighten that independently ?
| 
| thanks,
| jirka
