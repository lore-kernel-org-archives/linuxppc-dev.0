Subject: equivalent of touch_nmi_watchdog
From: Rajarshi Das <rajarshi@in.ibm.com>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Date: 29 Jun 2004 17:19:26 +0530
Message-Id: <1088509774.22425.54.camel@darya>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I am running some code which needs interrupts to be disabled for a
reasonable amount of time. A "touch_nmi_watchdog" call is done before
this code gets called on i386 platform. How do I do it on ppc64 ? I am
using a power 3 machine (type 7044-170) (uniprocessor) and a 2.6.6
kernel.

Thanks in advance,
Rajarshi.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
