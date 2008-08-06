Return-Path: <surendranath.moilla@cmcltd.com>
Message-ID: <19152.136.182.158.153.1218051991.squirrel@webmail.cmcltd.com>
Date: Thu, 7 Aug 2008 01:16:31 +0530 (IST)
Subject: problem in booting kernel with mpc836x_mds.dtb
From: surendranath.moilla@cmcltd.com
To: Linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
   I have the following problem, when i am trying to boot linux on
MPC8360E MDS board with the mpc836x_mds.dtb created using dtc and
mpc836x_mds.dts in from /arch/powerpc/boot/platforms/dts/ directory of
linux-2.6.22 version.

fdt_chosen: FDT_ERR_BADMAGIC

after this it is trying to re boot.
how to resolve this issue, so i need to apply any pathces to
mpc836x_mds.dts file.
NOTE: i am using dtc compiled from linux-2.6.26 version.

Regards
Surendra
