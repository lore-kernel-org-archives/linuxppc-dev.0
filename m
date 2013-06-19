Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 125AA2C02F5
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Jun 2013 15:33:19 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 23:33:18 -0600
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BE08538C8042
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Jun 2013 01:33:13 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5J5W584263236
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Jun 2013 01:32:05 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5J5W3G7010446
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Jun 2013 01:32:05 -0400
Date: Tue, 18 Jun 2013 22:31:13 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] perf/Power7: Save dcache_src fields in sample record.
Message-ID: <20130619053113.GA5025@us.ibm.com>
References: <20130607204008.GA3281@us.ibm.com>
 <23819.1371616910@ale.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23819.1371616910@ale.ozlabs.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling [mikey@neuling.org] wrote:
| Suka,
| 
| One of these two patches breaks pmac32_defconfig and I suspect all other
| 32 bit configs (against mainline)
| 
| arch/powerpc/perf/core-book3s.c: In function 'record_and_restart':
| arch/powerpc/perf/core-book3s.c:1632:4: error: passing argument 1 of 'ppmu->get_mem_data_src' from incompatible pointer type [-Werror]
| arch/powerpc/perf/core-book3s.c:1632:4: note: expected 'struct perf_sample_data *' but argument is of type 'struct perf_sample_data *'
| 
| benh is busy enough without this junk.  Please check the simple things
| like white space and compile errors!

Sorry about that.

BTW, this was an early patch more to get some feedback on mapping of
memory hierarchy levels to Power and not intended to be merged. I have
been reworking the patch based on other comments.

Sukadev
