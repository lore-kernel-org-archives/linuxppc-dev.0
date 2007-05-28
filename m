Return-Path: <lists@nerdbynature.de>
Received: from mail.g-house.de (ns2.g-housing.de [81.169.133.75])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A90B6DDED1
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 05:32:55 +1000 (EST)
Received: from [82.41.246.210] (helo=[10.0.0.30])
	by mail.g-house.de with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1HskxV-000393-34
	for linuxppc-dev@ozlabs.org; Mon, 28 May 2007 21:32:49 +0200
Date: Mon, 28 May 2007 20:32:47 +0100 (BST)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@ozlabs.org
Subject: zImage.miboot and vmlinux.lds
Message-ID: <Pine.LNX.4.64.0705282025250.6275@sheep.housecafe.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463809526-2098771339-1180380767=:6275"
Sender: "evil@g-house.de"@mail.g-house.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809526-2098771339-1180380767=:6275
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed

Hi,

when doing a "make mrproper" or even "make distclean" on a current 
2.6-git tree, I see 2 files being left over:

arch/powerpc/boot/zImage.miboot
arch/powerpc/kernel/vmlinux.lds

The attached 1-liner "fixes" this but I wonder why they've been kept at 
all.

thanks,
Christian
-- 
BOFH excuse #23:

improperly oriented keyboard
---1463809526-2098771339-1180380767=:6275
Content-Type: TEXT/x-diff; charset=US-ASCII; name=Makefile_powerpc.diff
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0705282032470.6275@sheep.housecafe.de>
Content-Description: 
Content-Disposition: attachment; filename=Makefile_powerpc.diff

LS0tIGxpbnV4LTIuNi1kZXYvYXJjaC9wb3dlcnBjL01ha2VmaWxlLm9yaWcJ
MjAwNy0wNS0yOCAyMToyNDozOS4wMDAwMDAwMDAgKzAyMDANCisrKyBsaW51
eC0yLjYtZGV2L2FyY2gvcG93ZXJwYy9NYWtlZmlsZQkyMDA3LTA1LTI4IDIx
OjIzOjI1LjAwMDAwMDAwMCArMDIwMA0KQEAgLTE3NSw2ICsxNzUsNyBAQCBh
cmNoY2xlYW46DQogDQogYXJjaG1ycHJvcGVyOg0KIAkkKFEpcm0gLXJmIGFy
Y2gvJChBUkNIKS9pbmNsdWRlDQorCSQoUSlybSAgLWYgYXJjaC8kKEFSQ0gp
L2Jvb3QvekltYWdlLm1pYm9vdCBhcmNoLyQoQVJDSCkva2VybmVsL3ZtbGlu
dXgubGRzIA0KIA0KIGFyY2hwcmVwYXJlOiBjaGVja2Jpbg0KIA0K

---1463809526-2098771339-1180380767=:6275--
