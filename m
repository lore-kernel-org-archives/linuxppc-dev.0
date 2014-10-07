Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04D871A0B0A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 17:28:40 +1100 (EST)
Message-ID: <1412663318.10747.2.camel@concordia>
Subject: Re: [RFC PATCH v3 1/3] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Tue, 07 Oct 2014 17:28:38 +1100
In-Reply-To: <20141003232606.GA9339@linux.vnet.ibm.com>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
 <20141002211305.GB12862@linux.vnet.ibm.com>
 <1412297420.2783.3.camel@concordia>
 <20141003232606.GA9339@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Fri, 2014-10-03 at 16:26 -0700, Nishanth Aravamudan wrote:
> On 03.10.2014 [10:50:20 +1000], Michael Ellerman wrote:
> > On Thu, 2014-10-02 at 14:13 -0700, Nishanth Aravamudan wrote:
> > > Ben & Michael,
> > > 
> > > What's the status of these patches?
> > 
> > Been in my next for a week :)
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next
> 
> Ah ok, thanks -- I wasn't following your tree, my fault. 

Not really your fault, I hadn't announced my trees existence :)

> Do we want these to go back to 3.17-stable, as they fix some annoying splats
> during boot (non-fatal afaict, though)?

Up to you really, I don't know how often/bad they were. I haven't added CC
stable tags to the commits, so if you want them in stable you should send them
explicitly.

cheers
