Message-ID: <D73A25AA6E54D511AD74009027B1110F5BAFEB@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: downloading source with specific changeset 
Date: Fri, 9 Jan 2004 15:30:28 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I was hoping someone with experience with bitkeeper could advise me on what
I am doing wrong.

I am trying to download a specific revision of the linuxppc_2_4_devel tree,
tag v2.4.21_linuxppc_2_4_devel, at
http://ppc.bkbits.net:8080/linuxppc_2_4_devel

The command I give is
bk clone -r1.1308.1.36 http://ppc.bkbits.net/linuxppc_2_4_devel

I thought the -r1.1308.1.36 would tell it to download up to changset
1.1308.1.36 but I keep getting the most recent version.  Can you please tell
me what I am doing wrong.

Thank you,
Steven Blakeslee

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
