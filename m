Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18364.57054.427433.405627@cargo.ozlabs.ibm.com>
Date: Thu, 21 Feb 2008 13:15:58 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2][POWERPC] Fix initial lmb add region with a non-zero
	base
In-Reply-To: <4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
References: <Pine.LNX.4.64.0802191350590.10089@blarg.am.freescale.net>
	<20080219.163003.152862383.davem@davemloft.net>
	<4130F47E-4F4A-4911-B63B-403A8C423565@kernel.crashing.org>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> np.  Are we trying to get this into 2.6.25 or .26?

I was going to put it into my powerpc-next branch and put it in
2.6.26.  I don't see any need for it to go in 2.6.25.

Paul.
