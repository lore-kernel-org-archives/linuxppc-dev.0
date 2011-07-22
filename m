Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC783B6F62
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Jul 2011 06:24:26 +1000 (EST)
Received: by fxe23 with SMTP id 23so5238852fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 22 Jul 2011 13:24:22 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH V2 0/2] powerpc/85xx: cleanup efforts
Date: Sat, 23 Jul 2011 00:23:35 +0400
Message-Id: <1311366217-15384-1-git-send-email-dbaryshkov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a second revision of patches, cleaning up mpc85xx support
Changes since V1:
* Temporarily drop questionable patches 
* Use common cpm2 init routing in stx_gp3.c
* Add powerpc/ prefix
