Return-Path: <dhowells@redhat.com>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0802181500410.13406@vixen.sonytel.be>
References: <Pine.LNX.4.64.0802181500410.13406@vixen.sonytel.be>
	<47B70A61.9030306@tiscali.nl>
	<20080216092552.325e5726@laptopd505.fenrus.org>
	<20080216173315.GU8953@1wt.eu>
	<20080216094226.1e8eede1@laptopd505.fenrus.org>
	<47B72BFE.9060302@am.sony.com>
	<20080216103927.2a02352b@laptopd505.fenrus.org>
	<1203249003.6718.24.camel@concordia>
	<20080218135609.GD21080@cs181133002.pp.htv.fi>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 1/3] Fix Unlikely(x) == y
Date: Mon, 18 Feb 2008 14:27:10 +0000
Message-ID: <12131.1203344830@redhat.com>
Sender: dhowells@redhat.com
Cc: Adrian Bunk <bunk@kernel.org>, Roel Kluin <12o3l@tiscali.nl>,
	lkml <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>,
	linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> Hence shouldn't we ask the gcc people what's the purpose of
> __builtin_expect(), if it doesn't live up to its promise?

__builtin_expect() is useful on FRV where you _have_ to give each branch and
conditional branch instruction a measure of probability whether the branch
will be taken.

David
