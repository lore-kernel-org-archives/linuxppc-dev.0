Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C78081A162A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Oct 2014 09:26:24 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 3 Oct 2014 17:26:22 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 92CBF19D8039
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Oct 2014 17:15:05 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s93NQLiP47317114
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 Oct 2014 01:26:21 +0200
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s93NQKSH017658
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Oct 2014 17:26:21 -0600
Date: Fri, 3 Oct 2014 16:26:06 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v3 1/3] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
Message-ID: <20141003232606.GA9339@linux.vnet.ibm.com>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
 <20141002211305.GB12862@linux.vnet.ibm.com>
 <1412297420.2783.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412297420.2783.3.camel@concordia>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Li Zhong <zhong@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03.10.2014 [10:50:20 +1000], Michael Ellerman wrote:
> On Thu, 2014-10-02 at 14:13 -0700, Nishanth Aravamudan wrote:
> > Ben & Michael,
> > 
> > What's the status of these patches?
> 
> Been in my next for a week :)
> 
> https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next

Ah ok, thanks -- I wasn't following your tree, my fault. Do we want
these to go back to 3.17-stable, as they fix some annoying splats during
boot (non-fatal afaict, though)?

-Nish
