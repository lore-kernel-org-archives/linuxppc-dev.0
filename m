Date: Mon, 27 Mar 2000 15:32:16 -0600
From: erik cameron <cameron@senta.uchicago.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: [cameron@senta.uchicago.edu: external video on powerbook g3 (lombard)]
Message-ID: <20000327153216.D14029@senta.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


sent this to linuxppc-user the other day, and i'm starting to wonder
whether i should have sent it to -dev to begin with.  is there a
way to drive an external monitor from a lombard powerbook under
linux that i've missed, or is the code just not there?  (i'm assuming
that the usb and/or sleeping code just doesn't support waking from
an external usb keyboard.)

----- Forwarded message from erik cameron <cameron@senta.uchicago.edu> -----

Date: Thu, 23 Mar 2000 17:35:23 -0600
From: erik cameron <cameron@senta.uchicago.edu>
To: linuxppc-user@lists.linuxppc.org
Subject: external video on powerbook g3 (lombard)
X-Mailer: Mutt 1.0pre3i

hi all...

i'd like to run my powerbook g3 lid closed, with an external monitor,
keyboard and mouse; i haven't found any docs on doing this, and my
efforts haven't met with any success.  the "normal" way of doing this
under macos (sleep, plug in monitor/keys/mouse, wake from ext. keys)
hasn't worked, as it doesn't seem the machine is able to wake from
an external usb keyboard.  i'm running the 2.2.15pre11 kernel from
paul mackerras's linux-pmac-stable tree, and using the OFfb video
device.  ("no video driver" checked in bootx.)  tia...

e

--
erik cameron  unix systems administrator
jfi/mrsec @ the university of chicago
e-cameron@uchicago.edu
http://senta.uchicago.edu/gnupg for public key

----- End forwarded message -----

--
erik cameron  unix systems administrator
jfi/mrsec @ the university of chicago
e-cameron@uchicago.edu
http://senta.uchicago.edu/gnupg for public key

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
