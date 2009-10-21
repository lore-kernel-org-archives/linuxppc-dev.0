Return-Path: <kodiakuppercut@gmail.com>
Received: from mail-iw0-f173.google.com (mail-iw0-f173.google.com
	[209.85.223.173]) by ozlabs.org (Postfix) with ESMTP id 04223B7B7A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 02:53:00 +1100 (EST)
Received: by iwn3 with SMTP id 3so3645221iwn.17
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 08:52:59 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 21 Oct 2009 09:52:58 -0600
Message-ID: <bc81dc640910210852l7c6d3f11ia0fb5524f952fe9d@mail.gmail.com>
Subject: e500 lowmem & TLBs
From: Aaron Pace <kodiakuppercut@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

For the e500 processors, it appears that the first 3 of 16 permanent
TLB entries are used to map lowmem.   Are the other 13 ever used?

Thanks,
-Aaron
