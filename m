Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF2EC1A042C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 10:59:35 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 30 Sep 2014 20:59:33 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 781AC38C8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 20:59:29 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s910xTK9131492
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 00:59:29 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s910xRsp013193
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 20:59:29 -0400
Date: Tue, 30 Sep 2014 17:59:05 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,2/4] Simplify catalog_read()
Message-ID: <20141001005905.GB4441@us.ibm.com>
References: <1411586681-21262-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141001003213.A8F78140273@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141001003213.A8F78140273@ozlabs.org>
Cc: ak@linux.intel.com, Michael Ellerman <michaele@au1.ibm.com>,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, eranian@google.com,
 Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 dev@codyps.com, Jiri Olsa <jolsa@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [mpe@ellerman.id.au] wrote:
| > @@ -203,6 +125,7 @@ static ssize_t catalog_read(struct file *filp, struct kobject *kobj,
| >  
| >  	page_offset = offset / 4096;
| >  	page_count  = count  / 4096;
| 
| I don't see where page_count is used.

Yes, I will remove it.

| 
| > +	offset_in_page = count % 4096;
| 
| Shouldn't offset_in_page be based on offset ?

Yes. I will fix that.

Thanks,

Sukadev
