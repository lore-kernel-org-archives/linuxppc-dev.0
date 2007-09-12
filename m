Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 09/15] Internal __spufs_get_foo() routines should take a
	spu_context *
Date: Wed, 12 Sep 2007 10:53:02 +0200
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<6e0eb3cefccb1e79c306afd10604f478069d768d.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <6e0eb3cefccb1e79c306afd10604f478069d768d.1189583010.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121053.02675.arnd@arndb.de>
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
> The SPUFS attribute get routines take a void * because the generic attribute
> code doesn't know what sort of data it's passing around.
> 
> However our internal __spufs_get_foo() routines can take a spu_context *
> directly, which saves plonking it in and out of a void * again.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
