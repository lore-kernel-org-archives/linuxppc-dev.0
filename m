Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 58832DE254
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 10:48:02 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so2248584pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 17:48:01 -0700 (PDT)
Subject: [PATCH 0/2] Fix 440 arch/ppc builds
From: Josh Boyer <jwboyer@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 21 Apr 2008 19:47:56 -0500
Message-Id: <1208825276.6654.41.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following two patches fix arch/ppc 440 builds.  Unless some miracle
occurs and people stop breaking arch/ppc with commits, this will likely
be the last kernel where it builds.

josh
