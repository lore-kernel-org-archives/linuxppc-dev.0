From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: "Robert Thompson" <rothomp3@vt.edu>
Subject: Re: trackpad
Date: Tue, 11 Jul 2000 22:54:16 +0200
Content-Type: text/plain
Cc: "Hollis Blanchard" <hollis@amulet.co.jp>, <pogtal@erols.com>,
        <linuxppc-dev@lists.linuxppc.org>
References: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu> <4.3.2.7.2.20000711172513.03963320@mail.munich.netsurf.de> <00e801bfeb51$d19bf300$1a6a1504@strayer.edu>
In-Reply-To: <00e801bfeb51$d19bf300$1a6a1504@strayer.edu>
MIME-Version: 1.0
Message-Id: <00071122541602.00729@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jul 2000, Robert Thompson wrote:

> > > Can you please post the dmesg part where all the ADB/USB devices get
> > registered to inputs? And please also the line which contains "adb
>
> devices"
>
> > in the dmesg and your kernel .config.
>
> Sure, find them attached.

All looks fine..., no idea what's going wrong for you. A new binary kernel
will be on Ben's page in a hour or so, please try that one.

Hmm, what procedure do you use to compile the kernel? If you use Ben's
.config unchanged (no make config/xconfig/menuconfig), it should look like
that:

  make oldconfig dep clean vmlinux modules modules_install

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
