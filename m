Return-Path: <aida.mynzhasova@skitlab.ru>
Received: from mail.skitlab.ru (mail.skitlab.ru [217.65.220.135])
 by ozlabs.org (Postfix) with ESMTP id 4001D2C034A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Oct 2013 01:54:45 +1100 (EST)
Message-ID: <525962B2.8010100@skitlab.ru>
Date: Sat, 12 Oct 2013 18:54:42 +0400
From: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: "powerpc/83xx: gianfar_ptp: select 1588 clock source through dts
 file" was added twice
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree@vger.kernel.org, davem@davemloft.net, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

recently I looked through commits in kernel/git/torvalds/linux.git and I 
noticed that my patch (old and new version) was added twice (by David S. 
Miller):

e58f6f4fb4eada7867014bfaec898f03afbce5c2
894116bd0e9b7749a0c4b6c62dec13c2a0ccef68

I think this is not good, and only 
e58f6f4fb4eada7867014bfaec898f03afbce5c2 should be added.

Thanks!

-- 
Regards,
Aida
