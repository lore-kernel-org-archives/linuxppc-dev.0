Content-Type: text/plain;
  charset="us-ascii"
From: Fernando Rodriguez <fernando@elec.gla.ac.uk>
To: linuxppc-dev@lists.linuxppc.org
Subject: Airport hard kernel freeze
Date: Thu, 1 Aug 2002 21:54:51 +0100
MIME-Version: 1.0
Message-Id: <200208012154.51693.fernando@elec.gla.ac.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry if this is a known issue...

I have a Tibook running kernel  2.4.18-8.1 with a built-in
airport card. The card is running with WEP encryption.
When there is heavy airport activity *and* there is a high
cpu load (gcc, sox, ...) *and* the laptop is far away from
the base station (leading into several eth1: Tx error,
status 4) the kernel locks up hard.  No logs, messages,
nothing.

The situation is perfectly repeatable, and each time, and
only in these conditions, the machine freezes; however
the lock-up is not immediate.  When the lock-up starts, I
can hear the swap and I/O stop, but I still have a few
(around 5-10) seconds where I can move the cursor,
activate windows, etc.  If during this time I do a sync, it
freezes immediatly.

Thanks a lot for your great! work guys.  If I can be of help, let me know.


Regards,

Fernando Rodriguez


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
