Message-ID: <3DA15DC6.9000808@intracom.gr>
Date: Mon, 07 Oct 2002 13:11:18 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: How to submit support for a new board
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello

We have a board based on a MPC850SR that I want to submit
for inclusion to the main tree.
Currently we work on the stable 2.4.19 branch.

The thing is that this board in kind of peculiar.

For example there's a driver for the multichannel controller
so that means that no serial port is available after booting.
That required to include the netconsole patch by Ingo
and make it work without being a module.

Given into account the scarcity of the dual port RAM under
such conditions I've added support for a malloc like
interface for DPRAM use, after taking into account
the uCode patches and any holes left over by the
enabled peripherals.

As you can see there is no chance in hell of getting
these included as they are.

How should I go about this given the feature freeze
for 2.6; but the 2.6 tree is too unstable for us.

Any suggestions?

Regards

Pantelis Antoniou
Intracom S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
