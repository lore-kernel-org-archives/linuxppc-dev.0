Return-Path: <phileas-fogg@mail.ru>
Received: from smtp32.i.mail.ru (smtp32.i.mail.ru [94.100.177.92])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 69FF02C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Mar 2013 23:08:34 +1100 (EST)
Received: from [37.49.86.97] (port=54462 helo=[192.168.1.240])
 by smtp32.i.mail.ru with esmtpa (envelope-from <phileas-fogg@mail.ru>)
 id 1UHCO5-0002ol-EA
 for linuxppc-dev@lists.ozlabs.org; Sun, 17 Mar 2013 16:08:29 +0400
Message-ID: <5145B20C.2090104@mail.ru>
Date: Sun, 17 Mar 2013 13:07:40 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Kernel panic on PowerMac G5 while scanning for SMU sensors
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I wanted to read the temperature sensors of my PowerMac G5 11,2.
For that i installed the lm-sensors package, run 'sensors-detect' 
command and my Linux 3.8.2 kernel paniced in

_smu_i2c_low_completion_

with this message

'Unable to handle kernel paging request for data at address 0x00000008.'

Regards
