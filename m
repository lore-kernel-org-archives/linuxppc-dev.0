Return-Path: <ml@stefan-roese.de>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
	by ozlabs.org (Postfix) with ESMTP id 18C37DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 22:41:36 +1000 (EST)
From: Stefan Roese <ml@stefan-roese.de>
To: linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Correct location for ADC/DAC drivers
Date: Tue, 1 May 2007 14:35:44 +0200
MIME-Version: 1.0
Message-Id: <200705011435.45046.ml@stefan-roese.de>
Content-Type: text/plain;
  charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I'm in the stage of integrating some ADC and DAC drivers for the AMCC 405EZ 
PPC and looking for the correct location to place these drivers in the Linux 
source tree. The drivers are basically character-drivers, so my first thought 
is to put them in "drivers/char/adc/foo.c" or "drivers/char/adc_foo.c". Is 
this a good solution?

Any suggestions welcome (could be that I missed an already existing example).

BTW: I am aware of the hwmon subsystem, but I don't think it fits my needs in 
this case.

Best regards,
Stefan
