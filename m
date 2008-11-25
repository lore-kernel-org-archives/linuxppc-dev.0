Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Carl Love <cel@us.ibm.com>
Subject: Re: [Patch 2/3] OProfile SPU event profiling support for IBM Cell
	processor
Date: Tue, 25 Nov 2008 16:58:26 +0100
References: <1227569201.6509.214.camel@carll-linux-desktop>
In-Reply-To: <1227569201.6509.214.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200811251658.27387.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, cel <cel@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	oprofile-list@lists.sourceforge.net, cbe-oss-dev <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 25 November 2008, Carl Love wrote:
> 
> This patch basically rearranges the code a bit to make it easier to
> just add the needed SPU event based profiling routines.   The second 
> kernel patch contains the new spu event based profiling code.

The cleanup looks fine, but should get a unique patch name, e.g. 
'[PATCH 2/3] powerpc/cell/oprofile: clean up event handling' to
make the shortlog more meaningful. No need to mention in the changelog
what the other patch does.

Please mention that this patch is not supposed to change any behaviour.

> Signed-off-by: Carl Love <carll@us.ibm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
