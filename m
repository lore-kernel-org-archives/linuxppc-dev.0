Message-ID: <412F7CF4.5020303@246tNt.com>
Date: Fri, 27 Aug 2004 20:27:00 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: request_irq called too soon ? What's the limit ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello

I was wondering why some test ISR I put up didn't get called. Finally I
found out that the "enable" function of the interrupt controller was not
called. So the interrupt showed in /proc/interrupts with the good name /
number but was not enabled.

At which point may I call this function ? These calls where from the
setup_arch function.


Thanks,

    Sylvain

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
