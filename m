Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17506.37259.755099.974824@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 11:21:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alan Modra <amodra@bigpond.net.au>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060511010438.GE24458@bubble.grove.modra.org>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
	<17506.21908.857189.645889@cargo.ozlabs.ibm.com>
	<20060511010438.GE24458@bubble.grove.modra.org>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, rth@twiddle.net,
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Modra writes:

> gcc shouldn't think there is any reason to cache the address.

Can I rely on that being true in the future?

Paul.
