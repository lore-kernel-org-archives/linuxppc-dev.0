Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11FA91A1A35
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 11:14:56 +1000 (AEST)
Message-ID: <1437527695.16792.3.camel@ellerman.id.au>
Subject: Re: [3/6] pseries: Update CPU hotplug error recovery
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Jul 2015 11:14:55 +1000
In-Reply-To: <55AE9A1E.5020002@linux.vnet.ibm.com>
References: <20150721044649.A4DD8140DF7@ozlabs.org>
 <55AE9A1E.5020002@linux.vnet.ibm.com>
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

On Tue, 2015-07-21 at 14:14 -0500, Nathan Fontenot wrote:
> On 07/20/2015 11:46 PM, Michael Ellerman wrote:
> > So the pr_info()s should go entirely and the pr_debugs() should become
> > pr_warns(). The warning messages should become more verbose so they stand on
> > their own, ie. include the drc_index.
> > 
> > When everything goes perfectly there should be no output.
> >
> 
> So... good idea, bad implementation :)

Well also a matter of perspective. For you these info messages are helpful
because you're working on the cpu hotplug code. But for other folks they're
just log spam.

> I have a feeling I may have messed this up somewhere else in the patch set too
> so I'll take a look at all the pr_* calls.

OK thanks.

cheers
