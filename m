Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] 64K page support for kexec
Date: Tue, 24 Apr 2007 01:08:41 +0200
References: <1177350832.16440.11.camel@luke-laptop>
	<1177365051.14873.23.camel@localhost.localdomain>
In-Reply-To: <1177365051.14873.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704240108.41894.arnd@arndb.de>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 23 April 2007, Benjamin Herrenschmidt wrote:
> On Mon, 2007-04-23 at 14:53 -0300, Luke Browning wrote:
> > This patch fixes a couple of kexec problems related to 64K page=20
> > support in the kernel. =A0kexec issues a tlbie for each pte. =A0The=20
> > parameters for the tlbie are the page size and the virtual address.
> > Support was missing for the computation of these two parameters
> > for 64K pages. =A0This patch adds that support. =A0
> >=20
> > Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

It's probably more appropriate to submit the patch to=20
paulus@samba.org and linuxppc-dev@ozlabs.org since it's
not cell specific.

When you resumbmit the patch with the correct line breaks,
just add the two Acked-by: lines to your Signed-off-by:
(in case that wasn't obvious).

	Arnd <><
