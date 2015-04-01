Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87FAF1A1147
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 05:27:40 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 1 Apr 2015 12:27:38 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 09C0FC90041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 14:18:44 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t31IRYrW28835974
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 18:27:34 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t31IRWvt017794
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2015 14:27:33 -0400
Date: Wed, 1 Apr 2015 11:26:32 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 08/10] perf/hv24x7: Whitespace cleanup
Message-ID: <20150401182632.GA4287@us.ibm.com>
References: <1427766828-771-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1427766828-771-9-git-send-email-sukadev@linux.vnet.ibm.com>
 <1427771281.14276.48.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427771281.14276.48.camel@perches.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joe Perches [joe@perches.com] wrote:
| On Mon, 2015-03-30 at 18:53 -0700, Sukadev Bhattiprolu wrote:
| > Fix minor whitespace damages.
| 
| If you are going to do whitespace cleaning,
| please verify the patches with scripts/checkpatch.pl --strict.

Ok. Will fix up parameter alignment with the open parens in a
follow on patch.

| 
| > diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
| []
| > @@ -1077,7 +1079,6 @@ static unsigned long single_24x7_request(struct perf_event *event, u64 *count)
| >  	}
| >  
| >  	resb = &result_buffer->results[0];
| > -
| >  	*count = be64_to_cpu(resb->elements[0].element_data[0]);
| >  out:
| >  	return ret;
| 
| Does this deletion make the code easier to read?
| 
| It might be better just to use:
| 
| 	be64 val;
| 	...
| 	val = result_buffer->results[0].elements[0].element_data[0];
| 	*count = be64_to_cpu(val);

Agree. Will include in a follow on patch.

Sukadev
