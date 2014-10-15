Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6DFC1A09AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 18:34:53 +1100 (EST)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 15 Oct 2014 08:34:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id D64F217D805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 08:37:03 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9F7YlrM59113618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 07:34:47 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9F7Ykon007657
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Oct 2014 01:34:46 -0600
Message-ID: <1413358473.2474.1.camel@TP420>
Subject: Re: [RFC PATCH v3 1/3] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 15 Oct 2014 15:34:33 +0800
In-Reply-To: <1413261346.19826.0.camel@concordia>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
 <20141002211305.GB12862@linux.vnet.ibm.com>
 <1412297420.2783.3.camel@concordia>
 <20141003232606.GA9339@linux.vnet.ibm.com>
 <1412663318.10747.2.camel@concordia>
 <20141007153346.GE9339@linux.vnet.ibm.com> <1413254364.2474.0.camel@TP420>
 <1413261346.19826.0.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 二, 2014-10-14 at 15:35 +1100, Michael Ellerman wrote:
> On Tue, 2014-10-14 at 10:39 +0800, Li Zhong wrote:
> > On 二, 2014-10-07 at 08:33 -0700, Nishanth Aravamudan wrote:
> > > On 07.10.2014 [17:28:38 +1100], Michael Ellerman wrote:
> > > > On Fri, 2014-10-03 at 16:26 -0700, Nishanth Aravamudan wrote:
> > > > > On 03.10.2014 [10:50:20 +1000], Michael Ellerman wrote:
> > > > > > On Thu, 2014-10-02 at 14:13 -0700, Nishanth Aravamudan wrote:
> > > > > > > Ben & Michael,
> > > > > > > 
> > > > > > > What's the status of these patches?
> > > > > > 
> > > > > > Been in my next for a week :)
> > > > > > 
> > > > > > https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next
> > > > > 
> > > > > Ah ok, thanks -- I wasn't following your tree, my fault. 
> > > > 
> > > > Not really your fault, I hadn't announced my trees existence :)
> > > > 
> > > > > Do we want these to go back to 3.17-stable, as they fix some annoying splats
> > > > > during boot (non-fatal afaict, though)?
> > > > 
> > > > Up to you really, I don't know how often/bad they were. I haven't added CC
> > > > stable tags to the commits, so if you want them in stable you should send them
> > > > explicitly.
> > > 
> > > I think they occur every boot, unconditionally, on pseries. Doesn't
> > > prevent boot, just really noisy. I think it'd be good to get them into
> > > -stable.
> > > 
> > > Li Zhong, can you push them once they get sent upstream?
> > 
> > I guess I only need to send the first two patches to stable? 
> 
> Probably. It's not clear from the changelog how serious a problem it fixes.
> 
> See Documentation/stable_kernel_rules.txt

OK, I'll send the first two to stable. 
Thanks, Zhong

> 
> cheers
> 
> 
> 
