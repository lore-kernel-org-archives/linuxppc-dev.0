From: benh@kernel.crashing.org
To: Stefan Piger <piger@rvs.uni-hannover.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Again with the firewire
Date: Thu, 22 Nov 2001 11:59:13 +0100
Message-Id: <20011122105913.4639@mailhost.mipsys.com>
In-Reply-To: <1006413308.947.0.camel@grobi>
References: <1006413308.947.0.camel@grobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>After loading the modules, there is no /proc/ohci1394 as I remember from
>earllier versions of linux1394.
>When I plug in a firewire device the keyboard becomes unusable, but the
>machine doesn't crash, I can reboot it via ssh.
>I get no error messages in /var/log/messages.
>
>Do you have any idea why it doesn't work? I tried the same on a friends
>Pismo an had the same effects!

Forget about /proc/ohci1394, it was bogus anyway.

Since you can log via ssh, can you send me the dmesg log that gets
displayed when you plug your device ? Eventulally, compile with the
excessive debugging output enabled in .config, and send me a log
with that too.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
