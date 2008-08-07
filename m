Return-Path: <dgibson@ozlabs.org>
Date: Thu, 7 Aug 2008 16:12:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
Message-ID: <20080807061254.GB12571@yookeroo.seuss>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060239.30717.79273.stgit@trillian.secretlab.ca>
	<ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0808060946v39992095pfb6b85726b7d307d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 11:46:47AM -0500, Timur Tabi wrote:
> On Wed, Aug 6, 2008 at 1:02 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > From: Grant Likely <grant.likely@secretlab.ca>
> >
> > of_lookup_stdout() is useful for figuring out what device to use as output
> > for early boot progress messages.  It returns the node pointed to by the
> > linux,stdout-path property in the chosen node.
> 
> I thought linux,stdout-path is deprecated are we're supposed to be
> using the aliases node instead?

During the ePAPR process this idea came up - standardising a 'stdout'
alias that would replace linux,stdout-path in chosen.  However that
was done in ignorance of the history of the linux,stdout-path property
and its connection to the stdout ihandle in chosen.  In any case, the
proposed 'stdout' alias didn't make the final cut for ePAPR, so how to
address this for flat-tree systems is still an open question.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
