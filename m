Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807291717g7096b8eas455964e0bbb637b9@mail.gmail.com>
Date: Tue, 29 Jul 2008 20:17:49 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: verbose kernel debug
In-Reply-To: <9e4733910807291709j49cacaa7gcc05f075f0691682@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910807291547p3ddd6b15nbe4516657e2e014f@mail.gmail.com>
	<488FA22C.5060100@freescale.com>
	<9e4733910807291612l5e0567d6t376c2f96c5169333@mail.gmail.com>
	<20080729234012.GA13708@secretlab.ca>
	<9e4733910807291709j49cacaa7gcc05f075f0691682@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, ppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why isn't PowerPC in the depends on?

config DEBUG_BUGVERBOSE
	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EMBEDDED
	depends on BUG
	depends on ARM || AVR32 || M32R || M68K || SPARC32 || SPARC64 || \
		   FRV || SUPERH || GENERIC_BUG || BLACKFIN || MN10300
	default !EMBEDDED
	help
	  Say Y here to make BUG() panics output the file name and line number
	  of the BUG call as well as the EIP and oops trace.  This aids
	  debugging but costs about 70-100K of memory.


-- 
Jon Smirl
jonsmirl@gmail.com
