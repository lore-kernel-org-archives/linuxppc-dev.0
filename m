Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17784.54471.964452.513068@cargo.ozlabs.ibm.com>
Date: Fri, 8 Dec 2006 13:58:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
In-Reply-To: <20061206222246.GG17931@austin.ibm.com>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
	<20061206222246.GG17931@austin.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> Clarify why twi appears in the i/o macros. Shorten some over-length
> lines, while we're at it.

[snip]

> + * A data-dependent branch followed by an isync ensures that no

I think it's potentially confusing to talk about data-dependent
branches when what the code does is a twi instruction.  Even if you
argue that a twi is a data-dependent branch (and I disagree with that,
since a trap is not a branch), that wouldn't be obvious to a casual
reader of the code.  In other words, I don't think the comment
clarifies the situation very much.

Paul.
