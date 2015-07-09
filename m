Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADF3B1A1D0F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 07:32:08 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Thu, 9 Jul 2015 15:32:05 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 403463E40047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 15:32:02 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t69LVHKS59179176
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 14:31:17 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t69LW1oY022584
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2015 15:32:01 -0600
Date: Thu, 9 Jul 2015 14:30:58 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Stephane Eranian <eranian@google.com>, peterz@infradead.org
Subject: Re: [PATCH v4 4/7] powerpc/powernv: detect supported nest pmus and
 its events
Message-ID: <20150709213058.GC7255@us.ibm.com>
References: <1436360506-18805-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1436360506-18805-5-git-send-email-maddy@linux.vnet.ibm.com>
 <20150708220125.GA22635@us.ibm.com>
 <559E2A7E.4040607@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <559E2A7E.4040607@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
| 
| > Are the 'start.*' and 'unit.*' files events by themselves or just attributes
| > of events?
| 
| These are attributes needed for computation. unit and scale attributes
| will be used by perf tool in post-processing the counter data. These
| can also use by other tools like pcp.

OK. Thanks for clarifying.
