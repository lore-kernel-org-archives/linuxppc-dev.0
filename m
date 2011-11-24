Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 0825E1007DB
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 21:30:43 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 18829-06 for <linuxppc-dev@ozlabs.org>;
 Thu, 24 Nov 2011 10:23:56 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/2] powerpc/85xx: Renamed mpc85xx_common.c to common.c
Date: Thu, 24 Nov 2011 10:22:05 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AEDF@saturn3.aculab.com>
In-Reply-To: <1322118527-14348-2-git-send-email-galak@kernel.crashing.org>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> Subject: [PATCH 2/2] powerpc/85xx: Renamed mpc85xx_common.c=20
> to common.c
>=20
> The file name is already scoped by the directory its in.
...
> rename from arch/powerpc/platforms/85xx/mpc85xx_common.c
> rename to arch/powerpc/platforms/85xx/common.c

All very well until you only have a reference to the
filename part somewhere and want to 'find' the file
in a large directory tree.

	David
