Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id C948CDDF2F
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 05:08:05 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/7] Basic Freescale MPC512x support
Date: Tue, 8 Jan 2008 19:07:58 +0100
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
In-Reply-To: <1199808093-15929-4-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801081907.59052.arnd@arndb.de>
Cc: John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 January 2008, John Rigby wrote:
> =A0obj-$(CONFIG_PPC_CHRP)=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D chrp/
> =A0obj-$(CONFIG_40x)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D 40x/
> =A0obj-$(CONFIG_44x)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D 44x/
> +obj-$(CONFIG_PPC_512x)=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D 512x/
> =A0obj-$(CONFIG_PPC_MPC52xx)=A0=A0=A0=A0=A0=A0+=3D 52xx/
> =A0obj-$(CONFIG_PPC_8xx)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D 8xx/
> =A0obj-$(CONFIG_PPC_82xx)=A0=A0=A0=A0=A0=A0=A0=A0=A0+=3D 82xx/

Why do you name the directory 512x instead of 51xx, which would be
more consistent with the others? Do you expect other 51xx chips that
are mostly incompatible with 512x?

Moreover, is it really so different from 52xx that it needs a separate
directory? E.g. we often treat the 74xx and 7xx as 6xx variants.

	Arnd <><
