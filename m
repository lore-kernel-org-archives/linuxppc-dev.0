Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18739.1091.452314.941676@cargo.ozlabs.ibm.com>
Date: Mon, 1 Dec 2008 08:23:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: powerpc: hv{cs, si}_close() both unsigned hp->count and
	hvcsd->open_count cannot be negative
In-Reply-To: <20081130111614.21b194c5@lxorguk.ukuu.org.uk>
References: <4931201D.7060701@gmail.com>
	<18737.52782.650416.444270@cargo.ozlabs.ibm.com>
	<20081130111614.21b194c5@lxorguk.ukuu.org.uk>
Cc: roel kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Cox writes:

> See the tty_port patches in -next - this is an argument about code which
> ought eventually to go away replaced by standard helper functions.

OK.  In that case I think the best fix for the existing code is just
to change the count to be int rather than unsigned int.

Paul.
