Return-Path: <srs0=ytby=7g=nefkom.net=whitebox@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPHhQ5R1NzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 05:55:02 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xPHhQ4kGJz8vyj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Aug 2017 05:55:02 +1000 (AEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xPHhQ1vJpz9rxm
 for <linuxppc-dev@ozlabs.org>; Sat,  5 Aug 2017 05:55:01 +1000 (AEST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 3xPHhL5GsDz1qrMr
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2017 21:54:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 3xPHhL3krhz3jR9b
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2017 21:54:58 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024) with ESMTP id Jv2jwR7eCHBU for <linuxppc-dev@ozlabs.org>;
 Fri,  4 Aug 2017 21:54:58 +0200 (CEST)
Received: from igel.home (ppp-88-217-1-226.dynamic.mnet-online.de
 [88.217.1.226])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2017 21:54:57 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: 4.13-rc3: Unrecoverable exception 4100
References: <87vam3lhtn.fsf__12885.8019285419$1501844971$gmane$org@linux-m68k.org>
 <87fud7ktqf.fsf__17563.3519575515$1501875675$gmane$org@linux-m68k.org>
Date: Fri, 04 Aug 2017 21:54:57 +0200
In-Reply-To: <87fud7ktqf.fsf__17563.3519575515$1501875675$gmane$org@linux-m68k.org>
 (Andreas Schwab's message of "Fri, 04 Aug 2017 21:39:36 +0200")
Message-ID: <877eyjkt0u.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No, this is really a 4.13-rc1 regression.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
