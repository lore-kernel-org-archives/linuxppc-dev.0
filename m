Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r42SM1MVZzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 00:58:27 +1000 (AEST)
Received: by mail-pa0-x229.google.com with SMTP id xk12so6561819pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 07:58:27 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: aneesh.kumar@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [v1] Basic Radix Tree cleanups
Date: Wed, 11 May 2016 00:57:40 +1000
Message-Id: <1462892262-18066-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch cleans up some bits of the radix tree implementation
no functionality changes were introduced. Most of them were based
on review comments. I've lightly tested the patches and checked
for correctness of code generation for the .long instruction change
bits. Please review
