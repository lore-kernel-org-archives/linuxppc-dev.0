Return-Path: <ananth@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54E452C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 15:45:21 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 5 Sep 2012 01:45:17 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 51C04C9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 01:45:07 -0400 (EDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q855j6am150736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2012 01:45:07 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q855j4PE010955
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Sep 2012 23:45:06 -0600
Date: Wed, 5 Sep 2012 11:15:00 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5 3/3] powerpc: Uprobes port to powerpc
Message-ID: <20120905054459.GB12521@in.ibm.com>
References: <20120824072602.GA32031@in.ibm.com>
 <20120824073132.GC32031@in.ibm.com> <1346822819.2257.49.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346822819.2257.49.camel@pasglop>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, peterz@infradead.org,
 lkml <linux-kernel@vger.kernel.org>, oleg@redhat.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Ingo Molnar <mingo@elte.hu>, ppcdev <linuxppc-dev@lists.ozlabs.org>
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2012 at 03:26:59PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2012-08-24 at 13:01 +0530, Ananth N Mavinakayanahalli wrote:
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > 
> > This is the port of uprobes to powerpc. Usage is similar to x86.
> 
> Guys, can you do a minimum of build testing ?
> 
> This one breaks due to uprobe_get_swbp_addr() being defined in both
> asm and include/linux when CONFIG_UPROBE isn't set. You don't need
> to define it at all in fact, the generic code takes care of both the
> declaration for CONFIG_UPROBE and the empty inline for !CONFIG_UPROBE.
> 
> I'm fixing that one up myself but please, please, get yourself a test
> build script or something to make sure you don't at least break the
> build when the stuff you're adding isn't enabled (among others).

Sorry Ben. That was an oversight. Won't happen again.

Regards,
Ananth
