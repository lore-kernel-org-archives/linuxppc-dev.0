Message-ID: <003b01bfeb47$848cf960$1a6a1504@strayer.edu>
From: "Robert Thompson" <rothomp3@vt.edu>
To: "Hollis Blanchard" <hollis@amulet.co.jp>
Cc: <pogtal@erols.com>, <linuxppc-dev@lists.linuxppc.org>
References: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu> <396ACDF9.826580D3@amulet.co.jp>
Subject: Re: trackpad
Date: Tue, 11 Jul 2000 10:51:34 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Hmm... anybody have any clue what's different
> > between the trackpad on the Pismo and on the iBook? It's not like ADB
isn't
> > working: the keyboard works fine, so ADB is working at least mostly
fine.
> > Like
> > I said, I use an external trackball anyway, but I'm sure somebody will
be
> > angry
> > about this at some point...
>
> Robbie, I missed the beginning of the thread, but did you follow Ben's
> directions?

Yes, I followed them exactly. Like I said, external usb mice work fine, and
the internal adb keyboard works fine, but the trackpad (also adb) doesn't
work at all. I tried gpm -m /dev/mouse -t imps2 and several variations
thereof, but nothing worked. The trackpad is detected correctly by the
kernel, according to dmesg. There are no errors reported of any kind, the
trackpad simply does nothing.

Thanks,
Robbie Thompson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
