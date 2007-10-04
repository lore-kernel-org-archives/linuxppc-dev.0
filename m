Return-Path: <dgibson@ozlabs.org>
Date: Thu, 4 Oct 2007 15:20:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Refactor Makefiles
Message-ID: <20071004052053.GH6024@localhost.localdomain>
References: <20071003055933.GE18978@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071003055933.GE18978@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 03, 2007 at 03:59:33PM +1000, David Gibson wrote:
> This patch makes a number of Makefile cleanups and improvements:
> 	- We use more generic rules to invoke flex and bison, which is
> useful for some of the other changes.
> 	- We use the name dtc-lexer.lex.c for the flex output, instead
> of the default lex.yy.c.  That means less potential for confusion if
> dtc is embedded into other projects (e.g. the kernel).
> 	- We separate out a Makefile.dtc designed for embedding into
> other projects, analagous to Makefile.libfdt.
> 	- Makefile.libfdt is cleaned up to be more useful based on
> some actual trial runs of embedding libfdt in the kernel bootwrapper.
> 	- Versioning related rules and variables are collected into
> one place in the Makefile.

Crap.  Don't apply, this seems to break the autodependency generation
for libfdt.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
