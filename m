Message-ID: <01C0807B.1BFF1AD0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: TCP Server stops accepting after 10mins - SOLVED
Date: Wed, 17 Jan 2001 11:46:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I finally got this one resolved.  Thanks a zillion to Bill Gatliff
for inspiration and his time.

The problem turned out to be that the embedded MBX860 unit
was assigned the same IP addr as one of the switches on our LAN.
So the switch must have been executing some security measure
that caused connects to be refused after a period of time.

Once I changed the MBX860's IP addr, the problem evaporated.

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
