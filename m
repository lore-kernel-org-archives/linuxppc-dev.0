Message-Id: <199812220007.SAA00492@lists.linuxppc.org>
Date: Mon, 21 Dec 1998 19:07:42 -0500 (EST)
From: "Jim Somerville" <Jim.Somerville.somer@nortelnetworks.com>
Reply-To: "Jim Somerville" <Jim.Somerville.somer@nortelnetworks.com>
Subject: MCP750 and CPX2000 System
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi All,

I just wanted to tell the community that I have successfully netbooted an
MCP750, as part of a CPX2000 system.  It's a rescue kernel, and I had to work
around the fact that I did not have residual data.  Thanks to Eric Valette,
and transitive thanks to all the developers that he thanked...  now I just
have to figure out how to get a full blown installation happening to disk.

Problems so far:
It finds the NCR scsi controller chip, but ends up timing out on some scsi
command.  I don't know what the command is yet.  With this problem, I can't
get at the disk and the cdrom.

It finds two IDE controllers as expected.  No problem here.

It finds the 21140 ethernet chip, and programs it for MII.  I use ifconfig
to configure it, however RX seems to work but not TX.  Weird.

If anyone can provide help, I'm at somer@nortel.ca.  Hopefully this is not
related to not having residual data....

Cheers,

-Jim




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
