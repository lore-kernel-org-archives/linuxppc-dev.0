Message-ID: <3C476C2B.80306@ixiacom.com>
Date: Thu, 17 Jan 2002 16:28:27 -0800
From: Bryan Rittmeyer <bryan@ixiacom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc750 TAU problems?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

 From Configure.help in a recent linuxppc_devel_2_4 snapshot (2.4.17):

CONFIG_TAU
   G3 and G4 processors have an on-chip temperature sensor called the
   'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
   temperature within 2-4 degrees Celsius. This option shows the current
   on-die temperature in /proc/cpuinfo if the cpu supports it.

   Unfortunately, on some chip revisions, this sensor is very inaccurate
   and in some cases, does not work at all, so don't assume the cpu
   temp is actually what /proc/cpuinfo says it is.

Can anyone provide further details on which IBM PPC750CXe versions have
problematic TAU? It seems our 400 MHz parts work great with this driver
(25 to 30C when idle) but our 600 MHz grades always read out an
incorrect range of "11-13 C" or even "1-71 C" while at room temperature.
Increasing the sampling delay in temp.c has no effect.

-Bryan

--
Bryan Rittmeyer
mailto:bryan@ixiacom.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
