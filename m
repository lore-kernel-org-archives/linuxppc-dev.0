Return-Path: <dbaryshkov@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69203B6FC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 22:51:55 +1000 (EST)
Received: by wyg36 with SMTP id 36so1915745wyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 05:51:48 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V3 0/2] Improve CPC925 EDAC handling code on Maple
Date: Fri, 17 Jun 2011 16:51:45 +0400
Message-Id: <1308315107-29182-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, colleagues,

Another respin of this patchset.

Changes since previous version:
* Fix comments in cpc925_edac.c
* Rename cpc925_cpu_getmask() to cpc925_cpu_mask_disabled()
* Don't return an error from init code if it's a U3 and not U3H

 arch/powerpc/platforms/maple/setup.c |   41 +++++++++------------
 drivers/edac/cpc925_edac.c           |   67 +++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 25 deletions(-)

-- 
With best wishes
Dmitry
