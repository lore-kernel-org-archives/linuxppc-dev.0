Message-ID: <3CFFA5AF.DD247938@motorola.com>
Date: Thu, 06 Jun 2002 13:10:55 -0500
From: Josh Horvath <Joshua.Horvath@motorola.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Christian Schroeder <christian.schroeder@imms.de>
Subject: MPC823E USB controller - delay gates necessary?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The device errata for the MPC850 includes the CPM17 bug that states delay
gates are necessary on the USB pins.  The MPC823E errata sheet does not
mention this bug.

I recently read the message by Christian Schroeder about getting the USB
controller working on the TQM823L board (with an 823E processor).  He states
that the delay gates are necessary.  Is this true?

I've got a custom 823E board that doesn't include these gates and I'm having
trouble getting the controller working, and it's not totally clear to me if
it's a hardware or software problem.


Thanks,
-Josh

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
