From: jlquinn@us.ibm.com
To: Stephane GEORGES <sg@dalim.de>
cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <8525687A.0058F740.00@D51MTA03.pok.ibm.com>
Date: Thu, 3 Feb 2000 11:11:58 -0500
Subject: Re: Speed tests - G4-400 and PIII-600
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bogomips is a totally meaningless measure of performance.  It is a measure
of how many empty loops can run in a given time period.  This value is used
to calibrate short timing intervals in the kernel.  So it is only useful
for comparing how fast a machine can do absolutely nothing.  Check out the
BogoMips mini-HOWTO.

If you seriously want to benchmark the two machines, you first have to
decide what you are benchmarking - disk performance, processor speed,
memory bandwith, network performance, kernel performance, etc.  There are a
number of benchmark programs out there that attempt to generate reasonably
comparable numbers (I'm sure I will miss many favorites): lmbench,
bytemark, gcc benchmark suite (for testing performance regressions in gcc),
STREAM, HINT, to name a few.

Also, compiler versions significantly affect the performance as well.
egcs-1.1.2 is out of date.  gcc-2.95 includes a number of optimizations not
present.  The current mainline gcc contains even more optimization work.

FInally, unless you are just looking for bragging rights, the best
benchmark you can use is the applications you intend to run on these
machines.  Everything else is just an approximation.

Jerry Quinn
jlquinn@us.ibm.com



Stephane GEORGES <sg@dalim.de>@lists.linuxppc.org on 02/03/2000 03:34:07 AM

Sent by:  owner-linuxppc-dev@lists.linuxppc.org


To:
cc:   linuxppc-dev@lists.linuxppc.org
Subject:  Speed tests - G4-400 and PIII-600




I've made speed tests on programs running on my LinuxPPC on G4-400 Mhz AGP,
and on Pentium III 600 Mhz.

[snip]

Bogomips:
    - on Intel : ~ 600
    - on PowerPC: ~ 800

The test programs are dealing with run-length images processing.

I was disapointed by the fact that the Intel machine ran 25% faster
than the PowerPC machine.

I thought that a G4-400 was worth a PIII-800 ...
Maybe gcc including Alvitec patches will provide better performances ...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
