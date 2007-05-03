Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4] powerpc: 64K page support for kexec
Date: Thu, 3 May 2007 15:45:40 +0200
References: <1177626236.24866.99.camel@luke-laptop>
	<20070426223228.GA30000@lixom.net>
	<1178115551.24866.139.camel@luke-laptop>
In-Reply-To: <1178115551.24866.139.camel@luke-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705031545.41251.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 May 2007, Luke Browning wrote:
> This patch fixes a couple of kexec problems related to 64K page
> support in the kernel. =A0kexec issues a tlbie for each pte. =A0The
> parameters for the tlbie are the page size and the virtual address.
> Support was missing for the computation of these two parameters
> for 64K pages. =A0This patch adds that support.
>=20
> Same as previous versions without BUG_ON()s.
>=20
> Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: Olof Johansson <olof@lixom.net>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Paul, please include this in your next merge for 2.6.22.
