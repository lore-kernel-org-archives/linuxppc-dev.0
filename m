Message-Id: <4.3.2.7.2.20000711172513.03963320@mail.munich.netsurf.de>
Date: Tue, 11 Jul 2000 17:29:57 +0200
To: "Robert Thompson" <rothomp3@vt.edu>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: trackpad
Cc: "Hollis Blanchard" <hollis@amulet.co.jp>, <pogtal@erols.com>,
        <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <003b01bfeb47$848cf960$1a6a1504@strayer.edu>
References: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu>
 <396ACDF9.826580D3@amulet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 16:51 11.07.00, Robert Thompson wrote:

> > > Hmm... anybody have any clue what's different
> > > between the trackpad on the Pismo and on the iBook? It's not like ADB
>isn't
> > > working: the keyboard works fine, so ADB is working at least mostly
>fine.
> > > Like
> > > I said, I use an external trackball anyway, but I'm sure somebody will
>be
> > > angry
> > > about this at some point...
> >
> > Robbie, I missed the beginning of the thread, but did you follow Ben's
> > directions?
>
>Yes, I followed them exactly. Like I said, external usb mice work fine, and
>the internal adb keyboard works fine, but the trackpad (also adb) doesn't
>work at all. I tried gpm -m /dev/mouse -t imps2 and several variations
>thereof, but nothing worked. The trackpad is detected correctly by the
>kernel, according to dmesg. There are no errors reported of any kind, the
>trackpad simply does nothing.

Can you please post the dmesg part where all the ADB/USB devices get
registered to inputs? And please also the line which contains "adb devices"
in the dmesg and your kernel .config.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
