Date: Tue, 23 Mar 2004 12:02:31 +0100
Message-ID: <4057CCD40003780D@mssbzhh-int.msg.bluewin.ch>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: IBM 440GX, Ocotea...
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

we are currently trying to understand which PPC Linux
kernel tree is best suited for the IBM 440GX on the
Ocotea eval board. We would like to support the 405GP
and 440GP as well.

The Ocotea 440GX board seems to be supported in the
"linuxppc_2_4_devel" tree. Is this board configuration
up-to-date and still maintained?

A more up-to-date implementation seems to be in the
"linuxppc-2.4" tree. Are there some open issues or known
problems? I realized that the L2 cache has been disabled
recently:

  $ cat arch/ppc/platforms/ocotea.c
  ...
  /* Disable L2-Cache due to hardware issues */
  ibm440gx_l2c_disable();

Does this mean that the L2 cache is unusable on current
revisions of the chip? [That's why we would like to use
this chip.]

Does this tree support the 405GP and 440GP as well? Could
anybody make some comments on the stability? We currently
use the "linuxppc_2_4_devel" tree for these processors
with little problems.

It would be nice if somebody could shed some light on
these issues.

TIA.

Wolfgang.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
