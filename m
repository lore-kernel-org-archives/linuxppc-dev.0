Date: Fri, 19 Feb 1999 06:05:38 -1000 (HST)
From: Dean Takemori <dean@uhheph.phys.hawaii.edu>
Message-Id: <199902191605.GAA17127@uhhepn.phys.hawaii.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Header errors
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I'm attempting to install GNOME on my system and have run
into the same problem with two different libraries (ORBit-0.3.98
and gtk+-1.1.15-2)

It seems that the library headers #define _XOPEN_SOURCE and/or
_XOPEN_SOURCE_EXTENDED.  Apparently #defining these leads to
parse errors when #including arpa/inet.h or sys/ipc_buf.h.

Is this a known headers bug?

I'm running a LinuxPPC-R4 distribution with egcs-1.1.1 and
the samba 2.2.1 kernel on a Powerbook G3 Series.  Linux is
installed on a hard drive in the left media bay (it runs
perfectly there with the 2.2.1 kernel)



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
