Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [PATCH] Fix build failure in
	platforms/celleb/setup.c which CONFIG_VIRT_CPU_ACCOUNTING is
	not defined.
Date: Tue, 30 Oct 2007 09:52:28 +0100
References: <20071030035504.GW24243@bakeyournoodle.com>
In-Reply-To: <20071030035504.GW24243@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710300952.29354.arnd@arndb.de>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 30 October 2007, Tony Breeds wrote:
> Without this patch I get the following build failure
> =A0 CC =A0 =A0 =A0arch/powerpc/platforms/celleb/setup.o
> arch/powerpc/platforms/celleb/setup.c:151: error: 'generic_calibrate_decr=
' undeclared here (not in a function)
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
