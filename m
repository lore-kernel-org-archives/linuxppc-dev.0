Date: Thu, 22 Nov 2001 01:28:43 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: Stefan Piger <piger@rvs.uni-hannover.de>
Cc: benh@kernel.crashing.org, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Again with the firewire
In-Reply-To: <1006413308.947.0.camel@grobi>
Message-ID: <Pine.LNX.4.40.0111220058320.14868-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 22 Nov 2001, Stefan Piger wrote:

> After loading the modules, there is no /proc/ohci1394 as I remember from
> earllier versions of linux1394.
> When I plug in a firewire device the keyboard becomes unusable, but the
> machine doesn't crash, I can reboot it via ssh.
> I get no error messages in /var/log/messages.

I actually just had the same thing happen, only the entire console froze,
X and all. I don't know if the kernel was still working or not, I didn't
have another machine connected at the time. However, this is actually an
improvement for me - the ohci1394 module doesn't lock the PMU up and cause
the system to suddenly shutdown (this is a FireWire iBook). If I boot the
system with the FireWire device - a QPS CD-RW drive - plugged in, all is
fine.

Ben? The FireWire controller didn't seem to have a problem with power
management per se - I ran 'gscanbus' after a suspend/unsuspend cycle, and
it seemed to be ok with that.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
