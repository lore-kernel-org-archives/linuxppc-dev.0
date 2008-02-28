Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 27 Feb 2008 19:35:15 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: patchwork missing patches?
Message-ID: <20080227193515.6f8f09e5@zod.rchland.ibm.com>
In-Reply-To: <18373.60272.351572.363687@cargo.ozlabs.ibm.com>
References: <20080227093950.11c8f4af@zod.rchland.ibm.com>
	<18373.60272.351572.363687@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 28 Feb 2008 10:00:00 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Josh Boyer writes:
> 
> > I'm trying to find some patches that went to the list recently in
> > patchwork and they seem to be missing.  Here are a few:
> > 
> > http://ozlabs.org/pipermail/linuxppc-dev/2008-February/052196.html
> 
> That one was in "awaiting upstream" state since I put it in the
> bundle, then realized it should probably go through your tree, and
> didn't apply it.  I've put it back to "new" state now.

Ok.  Not sure why I couldn't find it under the "All" state earlier.  I
see it now.

> > http://ozlabs.org/pipermail/linuxppc-dev/2008-February/052164.html
> 
> I seem to recall putting that one in "changes requested" state, but
> now I can't find it either.  Strange...

"changes requested" is what I was expecting, but didn't see it.
Strange indeed.

> > http://ozlabs.org/pipermail/linuxppc-dev/2008-February/052129.html
> 
> Not sure where that one has gone.

It's not overly important, since it was whitespace corrupted and I have
a fixed version anyway.  But it's still odd it's not on patchwork.

> > http://ozlabs.org/pipermail/linuxppc-dev/2008-February/052050.html
> 
> I have been deleting patches that go through other maintainers to try
> to keep the number of patches down to a manageable level, and that
> includes ibm_newemac patches, since they go through Jeff Garzik.
> That's probably what happened to this one.  I'll leave ibm_newemac
> patches alone if you promise to clean them up periodically. :)

Oh, I didn't realize you could actually outright delete them.  I tend
to look after ibm_newemac because it's mostly related to 4xx and I get
to bug BenH to do the jgarzik bugging because he said he wants to be
the maintainer.  I have no problems cleaning them up.

josh
