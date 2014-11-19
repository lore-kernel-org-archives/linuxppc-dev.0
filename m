Return-Path: <logout128@yahoo.com>
Received: from nm19-vm10.bullet.mail.gq1.yahoo.com
 (nm19-vm10.bullet.mail.gq1.yahoo.com [98.136.217.215])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 312761A0808
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 23:04:56 +1100 (AEDT)
Message-ID: <546C8763.6020209@yahoo.com>
Date: Wed, 19 Nov 2014 13:04:51 +0100
From: =?UTF-8?B?TWFydGluIEt1a2HEjQ==?= <logout128@yahoo.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Fan management PowerMac7,2
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I was directed to this list on #ppc64/freenode IRC channel. I have 
PowerMac7,2 (AGP, 2xPowerPC 970(2.2) 2GHz) and I wanted to try kernel 
supporting kvm-pr module, which is not in 3.2.63 kernel provided with 
Debian Wheezy. I downloaded 3.14.24, compiled it using original config 
from 3.2.63 and after booting fan management does not work. I tried 
therm_pm72 (which is deprecated, but works well with Debian kernel) and 
windfarm_pm72 modules, but neither worked - after about five minutes 
from boot all fans go to maximum and stay this way no matter the CPU 
load or frequency.

I downloaded vanilla 3.2.64, compiled it the same way and there fans 
work with therm_p72 well. This kernel does not have kvm-pr, so I 
reverted to original kernel provided with Wheezy.

I looked to logs, i tried to search the web whether anyone had already 
the same problem, but it seems that nobody else described not to say 
solved this. Can anyone please point me to anything that would help? I 
can provide whatever log files required.

Thanks,

Martin Kukac
