Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel2.indieserve.net (cpanel2.indieserve.net [199.212.143.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWv1t0yNmzDql8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 23:48:01 +1000 (AEST)
Received: from [::1] (port=34776 helo=cpanel2.indieserve.net)
 by cpanel2.indieserve.net with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 (envelope-from <rpjday@crashcourse.ca>) id 1dhbLF-0003VV-DM
 for linuxppc-dev@lists.ozlabs.org; Tue, 15 Aug 2017 08:53:05 -0400
Date: Tue, 15 Aug 2017 08:53:05 -0400
Message-ID: <20170815085305.Horde.UHGi_X5RJB80EmE3IdmqXz3@crashcourse.ca>
From: rpjday@crashcourse.ca
To: linuxppc-dev@lists.ozlabs.org
Subject: should "linux-phandle" be "linux,phandle"?
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


   pedantic nitpickery but, in arch/powerpc/kernel/prom_init.c, line 2426,
should that diagnostic message print "<linux,phandle>" and not  
"<linux-phandle>"?

rday
