Date: Wed, 16 Jul 2003 14:58:02 -0400 (EDT)
From: ted <ted@2600.COM>
To: linuxppc-dev@lists.linuxppc.org
Subject: How to access another DSP device w/ TAS3001c?
Message-ID: <Pine.NEB.4.44.0307161343520.18512-100000@phalse.2600.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know what the PCM2 mixer control is about?  I'm wanting to use
another DSP/PCM device for listening to music (so that I can still receive
console beeps, etc), but I only see one DSP device in /dev/sound when
using the kernel driver.

My understanding is that ALSA handles this type of thing more gracefully,
but I've been unable to get it to produce any sound at all.  I even tried
the "loading+unloading dmasound_pmac first" trick (using the latest stable
drivers), but to no avail.  Everything looks fine, but applications using
ALSA refuse to work (or crash), and using OSS emulation appears to work,
but there's no sound output (yes, I've tried maxing out the mixer
controls).

So does anyone know how I can either get ALSA going, or get the kernel
driver to create another DSP device?

System is a PowerBook Titanium II w/ TAS3001c.  Let me know if you need
more info.  Any assistance would be greatly appreciated.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
