Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW3XS6R6TzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 22:06:32 +1100 (AEDT)
Message-ID: <1458817586.3742.1.camel@ellerman.id.au>
Subject: Re: [PATCH/RFC] ppc64 livepatch: frameless klp_return_helper using
 odd TOC
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <torsten@lst.de>, Balbir Singh <bsingharora@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, jeyu@redhat.com, jkosina@suse.cz,
 jikos@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
Date: Thu, 24 Mar 2016 22:06:26 +1100
In-Reply-To: <20160324080449.GA13139@lst.de>
References: <20160323155858.GB27110@lst.de> <56F34F85.7020408@gmail.com>
 <20160324080449.GA13139@lst.de>
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

On Thu, 2016-03-24 at 09:04 +0100, Torsten Duwe wrote:
> On Thu, Mar 24, 2016 at 01:23:01PM +1100, Balbir Singh wrote:
> > On 24/03/16 02:58, Torsten Duwe wrote:
> > > 
> > > 1. Heuristics are bad. The better they are, the more subtly the
> > >    way they might fail.
> [...]

> 
> This CR+4 code leaves only 1 slot, so sibling calls are extremely dangerous,
> as I mentioned. But with a little attention, this patch works very well.
> 
> I mostly wanted to hear opinions about a transient odd TOC value
> before I start polishing.

Hi Torsten,

I just posted the version I've been working on. I prefer it, but you'll
probably tell me that there's some horrible case it doesn't handle correctly :)

cheers
