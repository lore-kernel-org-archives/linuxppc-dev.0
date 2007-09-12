Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 06/15] Correctly calculate the size of the local-store to
	dump
Date: Wed, 12 Sep 2007 13:31:34 +0200
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<895526252184eee5548e553d1cfec642b7fc68b8.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <895526252184eee5548e553d1cfec642b7fc68b8.1189583010.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121331.35059.arnd@arndb.de>
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
> The routine to dump the local store, __spufs_mem_read(), does not take the
> spu_lslr_RW value into account - so we shouldn't check it when we're
> calculating the size either.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
