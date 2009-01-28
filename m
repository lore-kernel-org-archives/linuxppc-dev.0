Return-Path: <anton@ozlabs.org>
Date: Wed, 28 Jan 2009 21:56:01 +1100
From: Anton Blanchard <anton@samba.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] bootgraph: fix for use with dot symbols
Message-ID: <20090128105601.GB18368@kryten>
References: <19599.1233113450@neuling.org> <497FE4E7.8070303@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <497FE4E7.8070303@linux.intel.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Arjan,

> question for the ppc folks.... why does the "print symbol" magic format string
> thing print a dot symbol and not the real function name?
> Should that be fixed instead?

We have two symbols for each function, foo points to the function
descriptor, and .foo points to the instruction text. If we were to strip
the '.' when we print symbols then it would become harder to diagnose
some failures (eg branching to the function descriptor instead of the
instruction text).

Anton
