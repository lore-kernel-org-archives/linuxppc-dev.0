Message-ID: <3ADF222D.C860E056@nexus-tech.net>
Date: Thu, 19 Apr 2001 13:36:45 -0400
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: TDM on mpc823
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Sorry if this is off-topic (not really linux related).

With Dan's help I think I understand how the TDM/CPM works. But, I'm
still having problems getting the TDM to output the correct number of
bytes. If I set the CNT field in sirp to be <=4 everything works great.
But as soon as I go above 5 bytes, the TDM fails to send the correct
number and sometimes stuffs the bits in an incorrect slot. Can anyone
help me?

Thanks, Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
