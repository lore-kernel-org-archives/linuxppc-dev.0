Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Refactor Makefiles (v2) 
In-Reply-To: Your message of "Thu, 04 Oct 2007 15:37:43 +1000."
	<20071004053743.GI6024@localhost.localdomain>
References: <20071003055933.GE18978@localhost.localdomain>
	<20071004052053.GH6024@localhost.localdomain>
	<20071004053743.GI6024@localhost.localdomain>
Date: Mon, 15 Oct 2007 08:35:50 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IhQ6o-0002sf-6s@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> 
> Here's a corrected version.
> 
> dtc: Refactor Makefiles
> 
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
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
