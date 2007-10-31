Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 15:49:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [0/2] Embed a copy of dtc in the kernel source
Message-ID: <20071031044953.GG7772@localhost.localdomain>
References: <20071031032401.GD7772@localhost.localdomain>
	<DFBF9FAC-012A-47C6-9EC0-CDD365F67A97@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DFBF9FAC-012A-47C6-9EC0-CDD365F67A97@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 11:37:15PM -0500, Kumar Gala wrote:
> 
> On Oct 30, 2007, at 10:24 PM, David Gibson wrote:
> 
> > These two patches are a respin of my previous patch to merge a copy of
> > dtc into the kernel tree, so that kernel builds no longer depend on an
> > externally installed copy of dtc.
> >
> > This respin embeds a newer revision of dtc, and incorporates Sam
> > Ravnborg's preferred approach to Makefile integration.  Also, since so
> > many people whinged about it last time, I've split the patch into two
> > parts, the first is the too-large-for-the-list patch just verbatim
> > adding files and the second has the changes to existing kernel files
> > to build and use the embedded code.
> 
> What about doing part of this via git-submodule?

Uh.. where do I find out what that does?  My version of git (Ubuntu
gutsy) doesn't seem to know anything about it...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
