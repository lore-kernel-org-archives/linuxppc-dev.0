Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0C7B7DE54E
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 00:00:34 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2f26be4be72081b3c5b33101b439c368@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: submitted patches
Date: Thu, 8 Jan 2009 07:07:22 -0600
To: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoffrey.levand@am.sony.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I request the following patches in patchwork be considered for 2.6.29:

http://patchwork.ozlabs.org/patch/3778/
powerpc ps3: use smp_request_message_ipi

http://patchwork.ozlabs.org/patch/3780/
powerpc cell: use smp_request_message_ipi

I think they were marked changes requested becase the prereq had 
requested changes.  Now the fixed version has  merged.  They still 
apply cleanly.   I have no hardware to test them.


http://patchwork.ozlabs.org/patch/16340/
powerpc: check crash_base for relocatable kernel

I think this simple version should be merged and sent to stable for 28. 
  While Michael would like something more intellegent, I think the 
simple patch should go to stable and the code can be refined in the 
future.


http://patchwork.ozlabs.org/patch/16606/
powerpc: use common cpu_die

This one will change a build error into a possible runtime fault.  If 
such a fault can be avoided by simply using the existing generic 
methods then I think it should be merged.  Otherwise, it may be 
preferrable to change the config, althoguh its not obvious which 
options need to be changed to avpodthe error whereas , and any fault 
would require a suspend or hibernation attempt.


Except for the one deferred patch (whcih needs changes) my remaining 
patches are new and I think have descriptions os to their impact.

Thanks,
milton
