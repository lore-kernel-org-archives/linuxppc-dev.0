Date: Mon, 25 Nov 2002 14:44:32 -0500
From: Stefano Bodini <s.bodini@comcast.net>
Subject: Frozen ! any idea ?
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <5.1.0.14.0.20021125143442.00aa8df0@pop3.norton.antivirus>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all !

I have (for me) a curious problem.
I have an Embedded Planet RXP Classic credit card (ppc860) loaded with a
2.4.17 kernel (compiled with MontaVista Pro 2.1).
I'm able to load correctly the kernel and the filesystem .. all is working
just fine, but after 1 minute since the last command issued, the system
just freeze.
1 minute without any command issued and the system is gone .. no errors, no
messages, no logs, nothing.
Just doesn't accept anymore commands .. even the echo on the tty port is gone.

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
