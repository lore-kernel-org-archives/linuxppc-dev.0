Message-ID: <D73A25AA6E54D511AD74009027B1110F5BB0A1@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Karsten Jeppesen'" <kj-list@jeppesens.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Simple module question
Date: Thu, 19 Feb 2004 15:38:25 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


look into wait queues.

-----Original Message-----
From: Karsten Jeppesen [mailto:kj-list@jeppesens.com]
Sent: Thursday, February 19, 2004 3:29 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Simple module question



Aren't they all......


I am doing some heavy work in a write function.
But I have a poll wait loop (waiting for flash program end) where a lot
of time is wasted.
How do I tell the scheduler that I would like t surrender the CPU for
others to use?
I tried calling scheduler(), but that only crashed the kernel.
What is the correct way?

Sincerely,
Karsten


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
