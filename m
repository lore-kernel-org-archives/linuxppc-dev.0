Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] Export DCR symbols - resubmitting
Date: Wed, 8 Aug 2007 23:58:03 +0200
References: <1186609609.4053.19.camel@macg5-2.rchland.ibm.com>
In-Reply-To: <1186609609.4053.19.camel@macg5-2.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200708082358.03835.arnd@arndb.de>
Cc: Linuxppc-dev@ozlabs.org, paulus@samba.org,
	Murali Iyer <mniyer@vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 08 August 2007, Murali Iyer wrote:
> This patch is needed in order to compile kernel modules that uses some
> of the DCR functions. For example, compiling powerpc emac driver as
> module it is needed.

Ok, thanks!

> Arnd, Dennis Spathis pinged me about this today and I thought it was a
> closed issue but still open. If you find it okay please upstream it or
> let me know if any modifications needed. Thanks.

Paul, please apply in either for-2.6.24 or as a fix for 2.6.23. The patch
is obviously correct, as the now exported functions were meant to be
used by modules in the first place. No code in the kernel currently
uses it, so it's not urgent.

> Signed-off-by: Murali Iyer <mniyer@us.ibm.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
