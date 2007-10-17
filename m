Return-Path: <dgibson@ozlabs.org>
Date: Wed, 17 Oct 2007 10:33:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] bootwrapper: Bail from script if any command fails
Message-ID: <20071017003331.GA28260@localhost.localdomain>
References: <20071016213101.14117.43657.stgit@trillian.cg.shawcable.net>
	<20071016213107.14117.3858.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071016213107.14117.3858.stgit@trillian.cg.shawcable.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 16, 2007 at 03:31:07PM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Add the 'set -e' command to the wrapper script so that if any command
> fails then the script will automatically exit

Ah.. this will conflict with my patch to merge dtc (because that
touches the line invoking dtc to change the path to it).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
