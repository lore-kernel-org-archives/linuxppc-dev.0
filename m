Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Improve support for string escapes 
In-Reply-To: Your message of "Tue, 16 Oct 2007 16:42:02 +1000."
	<20071016064202.GC9052@localhost.localdomain>
References: <20071016064202.GC9052@localhost.localdomain> 
Date: Tue, 16 Oct 2007 08:14:20 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IhmFY-0002wD-Iv@jdl.com>
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
> dtc supports the use of C-style escapes (\n, \t and so forth) in
> string property definitions via the data_copy_escape_string()
> function.  However, while it supports the most common escape
> characters, it doesn't support the full set that C does, which is a
> potential gotcha.
> 
> Worse, a bug in the lexer means that while data_copy_escape_string()
> can handle the \" escape, a string with such an escape won't lex
> correctly.
> 
> This patch fixes both problems, extending data_copy_escape_string() to
> support the missing escapes, and fixing the regex for strings in the
> lexer to handle internal escaped quotes.
> 
> This also adds a testcase for string escape functionality.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Excellent.  Thanks.

> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ dtc/tests/string_escapes.c	2007-10-16 16:34:20.000000000 +1000
> @@ -0,0 +1,42 @@
> +/*
> + * libfdt - Flat Device Tree manipulation
> + *	Testcase for strinc escapes in dtc

Applied, modulo fixing that typo.

jdl
