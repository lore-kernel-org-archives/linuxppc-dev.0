Date: Tue, 9 Feb 1999 20:45:46 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Paul Mackerras <paulus@cs.anu.edu.au>
From: BenH <bh40@calva.net>
Subject: Xpmac compatibility
Message-Id: <19990209204546.006029@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Is the code that sends mouse buttons & movements as keycodes needed only
for Xpmac compatibility ? Or is it something standard ? I was thinking
about conditionally defining it, probably using the CONFIG_FB_COMPAT_XPMAC.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
