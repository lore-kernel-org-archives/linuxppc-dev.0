Return-Path: <dgibson@ozlabs.org>
Date: Wed, 26 Sep 2007 15:25:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Use a custom name for lexer output
Message-ID: <20070926052551.GC32097@localhost.localdomain>
References: <20070926040554.GA32097@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070926040554.GA32097@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 26, 2007 at 02:05:54PM +1000, David Gibson wrote:
> This patch makes dtc use the name dtc-lexer.lex.c for the flex output,
> instead of the default lex.yy.c.  If nothing else that makes the
> filename more obvious when/if dtc is embedded into other projects.
> 
> It also explicitly requests flex as the lexer generator, rather than
> using make's default $(LEX).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Jon, sorry, please ignore this.  Better version coming.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
