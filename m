Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vQ3r94zvxzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 07:03:53 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vQ3r8738Vz9s8J
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2017 07:03:52 +1100 (AEDT)
Date: Fri, 17 Feb 2017 14:03:45 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Alan Modra <amodra@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 anton@samba.org
Subject: Re: [RFC PATCH] powerpc: Fix dubious r0 usage
Message-ID: <20170217200344.GE21840@gate.crashing.org>
References: <1487333333-17221-1-git-send-email-mpe@ellerman.id.au>
 <20170217132125.GV3731@bubble.grove.modra.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170217132125.GV3731@bubble.grove.modra.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2017 at 11:51:25PM +1030, Alan Modra wrote:
> On Fri, Feb 17, 2017 at 11:08:53PM +1100, Michael Ellerman wrote:
> > Bleeding edge binutils no longer accepts r0 in places where the CPU
> > interprets the value as a literal 0.
> 
> Wow!  That was quite some cleanup.  I think I'd better turn the error
> into a warning..

It also catches programming errors, not just syntax errors.


Segher
