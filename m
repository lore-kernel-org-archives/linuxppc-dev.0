From: schinder@pobox.com
Date: Wed, 12 Jul 2000 09:10:17 -0400
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-t1 & t3: dmasound
Message-ID: <20000712091017.A29086@pobox.com>
References: <200007121106.MAA13142@hyperion.valhalla.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200007121106.MAA13142@hyperion.valhalla.net>; from iain@sandoe.co.uk on Wed, Jul 12, 2000 at 12:06:48PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jul 12, 2000 at 12:06:48PM +0100, Iain Sandoe wrote:
}
} has anyone got dmasound_awacs to produce output under test1-ac21 or test3?
}
} The same code base is the one I pack-ported to 2.2.17pre7/10 & works OK
} (with reservations) there.
}
} not a peep from 2.4.0-tx.  Modules load OK, nothing seems overtly broken (no
} crash, sndstat looks sensible, setting parameters works OK)... just no
} output.
}
} Happy to try & fix - but it would be useful to know whether there are *any*
} conditions under which it has worked.

This is on a Performa 6400.

linux% cat /dev/sndstat
PowerMac (AWACS rev 2) DMA sound driver:
	sound.format = 0x20 (signed 16 bit big)
	sound.speed = 44100Hz (phys. 44100Hz)
	sound.stereo = 0x1 (stereo)
	sq.block_size = 32768 sq.max_count = 4 sq.max_active = 4
	sq.count = 0 sq.rear_size = 12288
	sq.active = 0 sq.syncing = 0

linux% uname -a
Linux c22234-c.scllg1.pa.home.com 2.4.0-test1-ac21 #1 Wed Jun 21 23:15:08 EDT 2000 ppc unknown

The source is from Paul's developent tree.

I've compiled sound support in rather than as a module.  It works, but
the only way to control the volume is by using the Gnome mixer.  On
anything else I've tried (xmms, the CD player that comes with Gnome,
reaplayer), the volume sliders don't work.  But the sound is fine.

}
} Iain.
}

--
Paul Schinder
schinder@pobox.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
