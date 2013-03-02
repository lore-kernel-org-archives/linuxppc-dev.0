Return-Path: <phileas-fogg@mail.ru>
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [94.100.177.104])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 271EC2C0323
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2013 00:40:21 +1100 (EST)
Received: from [149.172.189.23] (port=38019 helo=[192.168.1.76])
 by smtp44.i.mail.ru with esmtpa (envelope-from <phileas-fogg@mail.ru>)
 id 1UBmff-0001V2-Tp
 for linuxppc-dev@lists.ozlabs.org; Sat, 02 Mar 2013 17:40:16 +0400
Message-ID: <51320F53.9040000@mail.ru>
Date: Sat, 02 Mar 2013 15:40:19 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Linux kernel 3.x problems on PowerMac G5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

recently i got a PowerMac G5 and installed Debian Linux 2.6.32 on it.
Everything works so far and Debian boots properly.

Today i tried to boot Linux 3 on the machine and it doesn't boot.
The Linux 3 kernel was cross-compiled by me.

On Linux 3.8.1 it hangs after this line:
---
windfarm: Drive bay control loop started.

And then i'm getting RCU stall call traces.

On Linux 3.2 it hangs too but not at the same place.
It hangs after some SCSI message.

Have anyone tested Linux 3 kernels on PowerMac G5 recently ?

Regards
