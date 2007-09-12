Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 08/15] Use spufs_coredump_num_notes everywhere,
	and don't NULL terminate
Date: Wed, 12 Sep 2007 10:55:39 +0200
References: <2900ea4dbfd6e98e71ff400cbd25d1283a278972.1189583010.git.michael@ellerman.id.au>
	<163f3c08c2c47d47103f234d6caa517ed9a44036.1189583010.git.michael@ellerman.id.au>
In-Reply-To: <163f3c08c2c47d47103f234d6caa517ed9a44036.1189583010.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709121055.40170.arnd@arndb.de>
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
> The spufs_coredump_read array is NULL terminated, and we also store the size.
> We only need one or the other, and storing the size should save a teensy bit
> of memory vs NULL terminating, so do that.

Given that we have another array in there with almost the same contents
and that is NULL terminated, I'd vote for doing it the other way and also
use NULL-termination instead of the count here.

	Arnd <><
