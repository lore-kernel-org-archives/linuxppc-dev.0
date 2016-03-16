Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ6yb62cBzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 21:23:35 +1100 (AEDT)
Message-ID: <1458123799.27361.3.camel@ellerman.id.au>
Subject: Re: [v3,1/8] powerpc: Create a helper for getting the kernel toc value
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Kosina <jikos@kernel.org>
Cc: linuxppc-dev@ozlabs.org, pmladek@suse.com, jeyu@redhat.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  duwe@lst.de, live-patching@vger.kernel.org,
 mbenes@suse.cz
Date: Wed, 16 Mar 2016 21:23:19 +1100
In-Reply-To: <alpine.LNX.2.00.1603150220231.3656@cbobk.fhfr.pm>
References: <3qNsms00H7z9snl@ozlabs.org>
 <alpine.LNX.2.00.1603150220231.3656@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-15 at 02:27 +0100, Jiri Kosina wrote:
> On Mon, 14 Mar 2016, Michael Ellerman wrote:
>
> > > Move the logic to work out the kernel toc pointer into a header. This is
> > > a good cleanup, and also means we can use it elsewhere in future.
> > >
> > > Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > > Reviewed-by: Torsten Duwe <duwe@suse.de>
> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > > Tested-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> >
> > Series applied to powerpc next.
> >
> > https://git.kernel.org/powerpc/c/a5cab83cd3d2d75d3893276cb5
>
> Thanks Michael; this is an excellent basis for ppc live patching, but FYI
> I am not merging that one to my tree just yet.

Yeah OK.

> The solution (*) for functions with non-trivial argument list is not there
> yet, and it's my requirement for this to be taken care of in a way that's
> not prone to easily-done human errors on the patch-producer side.

Sure. I'll try and get something working, though this merge window is not
starting well so I may not get time for a few weeks :)

cheers
