Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C39A71A065A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:31:37 +1100 (AEDT)
Message-ID: <1427275897.31588.2.camel@ellerman.id.au>
Subject: Re: [PATCH v4 0/3] powerpc: Enable seccomp filter support
From: Michael Ellerman <mpe@ellerman.id.au>
To: Purcareata Bogdan <b43198@freescale.com>
Date: Wed, 25 Mar 2015 20:31:37 +1100
In-Reply-To: <550FFCAB.8080409@freescale.com>
References: <1424247413-20753-1-git-send-email-bogdan.purcareata@freescale.com>
 <54F01C85.2020602@freescale.com>
 <1425070490.4645.86.camel@kernel.crashing.org>
 <550FFCAB.8080409@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, pmoore@redhat.com, paulus@samba.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 strosake@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-23 at 13:44 +0200, Purcareata Bogdan wrote:
> On 27.02.2015 22:54, Benjamin Herrenschmidt wrote:
> > On Fri, 2015-02-27 at 09:28 +0200, Purcareata Bogdan wrote:
> >> Ping?
> >
> > What is the ping for ?
> >
> > Ben.
> 
> Hello Ben,
> 
> I just wanted to check with you what's the current status of these 
> patches. I noticed in patchwork [1][2][3] that the patches are marked as 
> non-applicable.
> 
> As of today, I cloned Michael Ellerman's tree [4], applied the patches 
> on the master branch, compiled and tested. Tests pass both with the 
> libseccomp regression suite and my LXC tests.
> 
> Is there a specific tree I should send them against, or on another 
> mailing list? Is there any other reason the patches are not applicable?

I just haven't had time to review them properly.

Because you're touching the syscall path for all powerpc platforms it needs
more scrutiny than the average patch.

It should still make 4.1, probably :)

cheers
