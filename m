Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 63006679E6
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 12:00:29 +1000 (EST)
Date: Mon, 29 May 2006 04:00:27 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: snd-aoa: Sound gone after snd-aoa updates, on PB5,8
Message-ID: <20060529020027.GA3107@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi

After some updates from http://johannes.sipsolutions.net/snd-aoa.git/
in the last few hours/minutes sound's gone here. Without changing
sound settings intentionally here. 


$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 833.333000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 16.57
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld


/var/log/boot:

Mon May 29 03:08:52 2006: ^[[9;0]^[[14;0]Setting up ALSA...warning: 'alsactl restore' failed with error message 'ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: alsactl: set_controls:1088: snd_ctl_open error: No such file or directory'...ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: ALSA lib control.c:816:(snd_ctl_open_noupdate) Invalid CTL hw:0
Mon May 29 03:08:52 2006: amixer: Mixer attach hw:0 error: No such file or directory
Mon May 29 03:08:52 2006: done.

Excerpts from /var/log/kern.log:
--------------------------------------
May 29 03:08:54 debby1-6 kernel: [   24.296157] i2sbus: !!!!! WARNING !!!!!
May 29 03:08:54 debby1-6 kernel: [   24.305857] i2sbus: control: couldn't allocate resource
May 29 03:08:54 debby1-6 kernel: [   24.315558] i2sbus: going ahead
anyway

May 29 03:08:54 debby1-6 kernel: [   25.140174] snd-aoa-fabric-layout: found bus with layout 82 (using)

May 29 03:08:54 debby1-6 kernel: [   34.230912] snd-aoa-codec-onyx: found pcm3052
May 29 03:08:54 debby1-6 kernel: [   34.232445] snd-aoa-fabric-layout: can use this codec
May 29 03:08:54 debby1-6 kernel: [   34.307453] snd-aoa-codec-onyx: attached to onyx codec via i2c
May 29 03:08:54 debby1-6 kernel: [   34.318072] snd-aoa-codec-onyx: created and attached onyx instance
May 29 03:08:54 debby1-6 kernel: [   34.318080] PowerMac i2c bus mac-io 0 registered
May 29 03:08:54 debby1-6 kernel: [   34.336045] PowerMac i2c bus uni-n 0 registered
-------------------------------------


After the first errors (that is: No sound at all), I removed
asound.conf and asound.names in /etc/ completely, just to make sure I
have no mistakes in these files - to no avail so far. Kernel is
still the same as all the last 2 weeks or so, where alsa/snd-aoa
worked.

 uname -a 
Linux debby1-6 2.6.17-rc3-gf358166a-dirty #1 Fri May 12 01:13:36 CEST
2006 ppc GNU/Linux

# modinfo snd-aoa
filename:       /lib/modules/2.6.17-rc3-gf358166a-dirty/kernel/sound/aoa/snd-aoa.ko
description:    Apple Onboard Audio Sound Driver
author:         Johannes Berg <johannes@sipsolutions.net>
license:        GPL..
vermagic:       2.6.17-rc3-gf358166a-dirty mod_unload gcc-4.1
depends:        sndation.
srcversion:     2944C7BBEA1A2A72E3A8183

/etc/modprobe.d/sound:
-----------------
alias snd-card-0 i2sbus
#alias snd-card-0 snd-powermac
#options snd-powermac index=0
-------------------

Hints?

Best Regards
Wolfgang
-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
