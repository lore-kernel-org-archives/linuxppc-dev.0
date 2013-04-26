Return-Path: <wolfram@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 46F752C010D
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Apr 2013 01:29:56 +1000 (EST)
Date: Fri, 26 Apr 2013 17:31:00 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: Status of I2C mac-drivers needing attach_adapter?
Message-ID: <20130426153100.GA3104@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

because I will push a patch to get rid of detach_adapter() from the I2C
core in the next merge window, I was curious to find out about the
status of attach_adapter().

I found commit 6cd3209967469f6e89d329deda6bb0b4700e7b62
(powerpc/powermac: New windfarm driver for PowerMac G5 (AGP) and Xserve
G5) which should get rid of therm_pm72 if I understand correctly? Or is
it still needed? Can you give me an overview if there is/was progress
regarding the other two drivers therm_windtunnel and sound/ppc/keywest?

Thanks,

   Wolfram
