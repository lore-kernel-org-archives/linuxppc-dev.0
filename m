Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 203B31A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 02:34:12 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 7 Oct 2014 11:34:10 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8149D38C803B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 11:34:06 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s97FY6hd62128334
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Oct 2014 15:34:06 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s97FY5If011295
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Oct 2014 11:34:06 -0400
Date: Tue, 7 Oct 2014 08:33:46 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH v3 1/3] powerpc: Fix warning reported by
 verify_cpu_node_mapping()
Message-ID: <20141007153346.GE9339@linux.vnet.ibm.com>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
 <20141002211305.GB12862@linux.vnet.ibm.com>
 <1412297420.2783.3.camel@concordia>
 <20141003232606.GA9339@linux.vnet.ibm.com>
 <1412663318.10747.2.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1412663318.10747.2.camel@concordia>
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

On 07.10.2014 [17:28:38 +1100], Michael Ellerman wrote:
> On Fri, 2014-10-03 at 16:26 -0700, Nishanth Aravamudan wrote:
> > On 03.10.2014 [10:50:20 +1000], Michael Ellerman wrote:
> > > On Thu, 2014-10-02 at 14:13 -0700, Nishanth Aravamudan wrote:
> > > > Ben & Michael,
> > > > 
> > > > What's the status of these patches?
> > > 
> > > Been in my next for a week :)
> > > 
> > > https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=next
> > 
> > Ah ok, thanks -- I wasn't following your tree, my fault. 
> 
> Not really your fault, I hadn't announced my trees existence :)
> 
> > Do we want these to go back to 3.17-stable, as they fix some annoying splats
> > during boot (non-fatal afaict, though)?
> 
> Up to you really, I don't know how often/bad they were. I haven't added CC
> stable tags to the commits, so if you want them in stable you should send them
> explicitly.

I think they occur every boot, unconditionally, on pseries. Doesn't
prevent boot, just really noisy. I think it'd be good to get them into
-stable.

Li Zhong, can you push them once they get sent upstream?

Thanks,
Nish
