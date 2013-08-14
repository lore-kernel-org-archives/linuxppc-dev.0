Return-Path: <tobias@shiva.tv>
Received: from mailauth2.nine.ch (mailauth2.nine.ch [94.230.211.175])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "*.nine.ch", Issuer "PositiveSSL CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C80312C0200
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 00:23:12 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mailauth2.nine.ch (Postfix) with ESMTP id 197902C4F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 16:17:49 +0200 (CEST)
Received: from mailauth2.nine.ch ([127.0.0.1])
 by localhost (mailauth2.nine.ch [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zyoFvy3MdG3R for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 14 Aug 2013 16:17:47 +0200 (CEST)
Received: from [192.168.1.169] (unknown [213.173.165.82])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: tobias@shiva.tv)
 by mailauth2.nine.ch (Postfix) with ESMTPSA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 16:17:47 +0200 (CEST)
From: Tobias Stillger <tobias@shiva.tv>
Content-Type: text/plain; charset=us-ascii
Subject: Embedded System Question
Date: Wed, 14 Aug 2013 16:17:47 +0200
Message-Id: <C620D418-F0B6-41E0-B235-76AD33F80ED5@shiva.tv>
To: linuxppc-dev@lists.ozlabs.org
Mime-Version: 1.0 (Apple Message framework v1085)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have to struggle with a broadcast video decoder with an unknown PPC =
Linux. I would like to compile
a new module, but I need a build environment. Here some infos about the =
system:=20

Linux version 2.6.14-gemppc-iolite

processor	: 0
cpu		: 405GPr
clock		: 399MHz
revision	: 9.81 (pvr 5091 0951)
bogomips	: 398.33
machine		: GemPPC Iolite
plb bus clock	: 133MHz
pci bus clock	: 33MHz


GNU/Linux 2.6.14 port for the GemPPC Iolite platform

Is there a chance to work with this semi closed system.=20

Thanks in advance for all input.=20


=20=
