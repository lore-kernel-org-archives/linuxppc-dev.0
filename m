Message-Id: <199812200348.LAA24006@mule.wantree.com.au>
Subject: undefined symbol: _IO_2_1_stdin_
Date: Sun, 20 Dec 1998 14:15:35 +1030
From: Keith Jacob <kjacob@wantree.com.au>
To: "linux-pmac list" <linux-pmac@samba.anu.edu.au>,
        "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>,
        "linuxppc-user list" <linuxppc-user@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Any clues? Please?

Full errror is

error in loading shared libraries
: undefined symbol: _IO_2_1_stdin_

When?

Whenever I try to run pre-compiled binaries (mostly from stock LinuxPPC 
RPMs) from late-1998 builds.

BTW, Gary Thomas's latest egcs-1.1-1b RPMs include bins that exhibit this 
behaviour, e.g. gcc!

When I was using egcs-1.0-2e, and R4 packages there were no probs with 
bins I compiled myself.

TIA

--
Keith Jacob
kjacob@wantree.com.au




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
