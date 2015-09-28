Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB4841A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 03:05:05 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Mon, 28 Sep 2015 13:05:01 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 6A627C90045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 12:56:02 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8SH4w3s55181526
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 17:04:59 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8SH4v7t021442
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2015 13:04:58 -0400
Date: Mon, 28 Sep 2015 10:04:55 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 nikunj@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 anton@samba.org, grant.likely@linaro.org, cl@linux.com,
 khandual@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gkurz@linux.vnet.ibm.com
Subject: Re: [PATCH RFC 0/5] powerpc:numa Add serial nid support
Message-ID: <20150928170455.GA48470@linux.vnet.ibm.com>
References: <1443378553-2146-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <CAOJe8K1P+o9WsU1yW3aDJ5o5834hKU7qwSF3ZzdZef=iUY0-Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K1P+o9WsU1yW3aDJ5o5834hKU7qwSF3ZzdZef=iUY0-Aw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 28.09.2015 [13:44:42 +0300], Denis Kirjanov wrote:
> On 9/27/15, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> wrote:
> > Problem description:
> > Powerpc has sparse node numbering, i.e. on a 4 node system nodes are
> > numbered (possibly) as 0,1,16,17. At a lower level, we map the chipid
> > got from device tree is naturally mapped (directly) to nid.
> 
> Interesting thing to play with, I'll try to test it on my POWER7 box,
> but it doesn't have the OPAL layer :(

Note that it's also interesting to try it under PowerVM, with odd NUMA
topologies and report any issues found :)


-Nish
