Return-Path: <orutsch@sympatec.com>
Message-ID: <474BEC4F.3080800@sympatec.com>
Date: Tue, 27 Nov 2007 11:07:11 +0100
From: Oliver Rutsch <orutsch@sympatec.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: MPC5200 I2C and 2.6 kernel
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm using a TQM5200S (MPC5200B CPU) module on the STK52xx starter kit. 
For some reasons I have to use the 2.6 kernel (the latest 2.6.23.1 from 
the DENX git archive) with ARCH=powerpc and most of my external hardware 
is running fine with this.
On the starter kit there is an external I2C RTC (M41T00) and I like to 
use it now. In the 2.4 kernel there were some options regarding MPC5200 
I2C, but I could not find them in the 2.6 kernel.
There were options for MPCxxx I2C Algorithm or MPC5xxx TQM5200 I2C 
Adapter, for example.
Regardless what I'm doing in the 2.6 kernel configuration I can't get 
this RTC running (I activated RTC support and the driver for the M41T00 
in the configuration).
hwclock --debug tells me:

hwclock: Open of /dev/rtc failed, errno=19: No such device.
No usable clock interface found.

So the questions is: Is the I2C support for the MPC5200 in the 2.6.23 
kernel in an usable state? Or do I need some special patches from TQ for 
this board to get it running?

Thanks in advance and bye,

-- 
Dipl. Ing. Oliver Rutsch
EMail: orutsch@sympatec.com
