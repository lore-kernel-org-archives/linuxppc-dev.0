Date: Sun, 9 Nov 2003 14:12:29 +0000
To: linuxppc-dev@lists.linuxppc.org
Cc: habets_martin@yahoo.co.uk
Subject: Alsa error on powerbook 2.6.0-test9
Message-ID: <20031109141229.GA734@palantir7.mph.eclipse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: MPH Kernel <kernel@mph.eclipse.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I'm using Ben's 2.6.0-test9 kernel on a powerbook titanium.
I got alsa to work, but I get the following error in dmesg:

...
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003
 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
registering 0-0035
ALSA device list:
  #0: PowerMac Snapper (Dev 26) Sub-frame 0
NET: Registered protocol family 2
...

I have all alsa stuff built into the kernel, no modules.
I only have one soundcard, and since it is built-in no modules
are needed. If I'm right, the request comes from snd_request_card.

Anyone seen this?

Also, I get an (unrelated) error from alsactl:
# alsactl restore
/usr/sbin/alsactl-0.9: set_control:638: control.1.iface is invalid

But /etc/asound.state was written by alsactl store!

Thanks,
Martin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
