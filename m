Return-Path: <trini@kernel.crashing.org>
Date: Thu, 28 Apr 2005 09:13:59 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20050428161359.GF1221@smtp.west.cox.net>
References: <20050428153733.GD1221@smtp.west.cox.net>
	<22dae1b19bcada0dd96405d13454b6bf@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <22dae1b19bcada0dd96405d13454b6bf@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: rsync mirrors of linuxppc-* on source.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 28, 2005 at 12:02:13PM -0400, Dan Malek wrote:
> 
> On Apr 28, 2005, at 11:37 AM, Tom Rini wrote:
> 
> >....  is there any value in keeping
> >the rsync mirrors of the last state of the linuxppc-* trees available?
> 
> Have you been pulling any updates into these trees?

They are semi current with the linux-2.[46] versions, but probably not
100% up to date.

> I would like to keep an archive copy, as there is still code in them
> that hasn't migrated into main trees.  I guess the longer we wait
> the less value that has, but I'd like to not lose it.  I don' t have
> any problem hosting the archives if people still want to use them
> for future reference.

For the linuxppc-2.5 tree, I did a dirdiff'ing prior
to the BK thing comming up and either submitted things, or gave to Paul
/ Matt Porter what I found (as it was 4xx things) to deal with.

For the linuxppc-2.4 tre, I know there's stuff that never went to
Marcelo.

I'll go re-activate rsync for the trees and have a comment about them
being historical archives.

-- 
Tom Rini
http://gate.crashing.org/~trini/
