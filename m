Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0485@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Stefano Bodini'" <s.bodini@comcast.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Frozen ! any idea ?
Date: Mon, 2 Dec 2002 09:00:34 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Do you have the watch dog timer enabled?  This could be the problem.

-----Original Message-----
From: Stefano Bodini [mailto:s.bodini@comcast.net]
Sent: Monday, November 25, 2002 2:45 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Frozen ! any idea ?



Hi all !

I have (for me) a curious problem.
I have an Embedded Planet RXP Classic credit card (ppc860) loaded with a
2.4.17 kernel (compiled with MontaVista Pro 2.1).
I'm able to load correctly the kernel and the filesystem .. all is working
just fine, but after 1 minute since the last command issued, the system
just freeze.
1 minute without any command issued and the system is gone .. no errors, no
messages, no logs, nothing.
Just doesn't accept anymore commands .. even the echo on the tty port is
gone.

About the 1 minute value, I did some tests to figure out the timing and is
more or less 1 minute.
Up to 30-45 secs. and the system still react, after (50-70 secs) the system
freeze.
If you continue to issue commands the system doesn't freeze .. but it do it
as long as you stop to issue commands.

I tried to load also the default kernel image for that board .. same result.
It seems a kind of watch dog or timer .. but I don't understand why all is
frozen !

Any idea ?

Thanks in advance

C'ya
	Steve


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
