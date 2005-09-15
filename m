Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17193.64509.576852.408757@cargo.ozlabs.ibm.com>
Date: Fri, 16 Sep 2005 08:55:57 +1000
From: Paul Mackerras <paulus@samba.org>
To: "John W. Linville" <linville@tuxdriver.com>
In-Reply-To: <20050915140659.GA17670@tuxdriver.com>
References: <20050915160430.550d02ed.sfr@canb.auug.org.au>
	<20050915140659.GA17670@tuxdriver.com>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: don't execute a temporary comment
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John W. Linville writes:

> Why is this helpful?  Better in general to keep the commment near the code, no?

Where it was, it was a command, not a comment, so it got printed out
on the screen when you did a make clean, which seemed a bit silly.

Paul.
