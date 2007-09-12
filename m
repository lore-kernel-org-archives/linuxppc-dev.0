Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 11/15] Combine spufs_coredump_calls with spufs_calls
Date: Wed, 12 Sep 2007 10:51:32 +0200
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<5d0eaf2dbfd1046983f3e6f96ff6b8d967ec3801.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <5d0eaf2dbfd1046983f3e6f96ff6b8d967ec3801.1189583010.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121051.33187.arnd@arndb.de>
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 September 2007, Michael Ellerman wrote:
> Because spufs might be built as a module, we can't have other parts of the
> kernel calling directly into it, we need stub routines that check first if the
> module is loaded.
> 
> Currently we have two structures which hold callbacks for these stubs, the
> syscalls are in spufs_calls and the coredump calls are in spufs_coredump_calls.
> In both cases the logic for registering/unregistering is essentially the same,
> so we can simplify things by combining the two.

Nice cleanup!

> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
