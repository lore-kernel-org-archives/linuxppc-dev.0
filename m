Date: Thu, 10 Oct 2002 14:35:02 -0400
From: Patrick Mahoney <pmahoney@8d.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: mpc8xx - power save modes - PIT
Message-ID: <20021010183502.GA843@segfault.usine.8d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello pple,

My setup: MPC850 on a RPXlite_dw board.

My problem:

I am trying toggle between power saving modes and evaluate the current
drops with an ampermeter.

I succeeded in switching to several power modes, but each time i
switch, my serial connection dies, even if i switch to the  'normal
low mode', which is supposed to keep all functionnalities  present.

I am looking to use the PIT to automatically bring back the chip to
normal full power mode.

I tried the following:

      init_timer(&timer);
      timer.expires=1000;
      timer.function=timer_handler;
      add_timer(&timer);

without success. The kernel oops'es everytime. Ive been browsing the
kernel sources, but have yet to see where the PIT was
initialized/used.

Would anyone have successfully used the several power modes of the
mpc850 (or equivalent) through linux 2.4? If so, is there any code
snippet available?

Also, do you have any idea as to why the serial connection dies? Is it
a uart syncing -type problem?

Best regards,


Pat Mahoney

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
