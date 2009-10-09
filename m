Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Oct 2009 17:36:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 10/12] of: merge of_*_flat_dt*() functions
Message-ID: <20091009063635.GD12948@yookeroo.seuss>
References: <20091007041007.16890.62194.stgit@angua>
	<20091007043154.16890.18883.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091007043154.16890.18883.stgit@angua>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu,
	devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 06, 2009 at 10:32:02PM -0600, Grant Likely wrote:
> Merge common flattened device tree code between Microblaze and PowerPC

And I guess another question is do we want to replace these with a
libfdt based implementation.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
