Message-ID: <003d01bfeb7c$50f3f2e0$1a6a1504@strayer.edu>
From: "Robert Thompson" <rothomp3@vt.edu>
To: "Franz Sirl" <Franz.Sirl-kernel@lauterbach.com>
Cc: "Hollis Blanchard" <hollis@amulet.co.jp>, <pogtal@erols.com>,
        <linuxppc-dev@lists.linuxppc.org>
References: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu><4.3.2.7.2.20000711172513.03963320@mail.munich.netsurf.de><00e801bfeb51$d19bf300$1a6a1504@strayer.edu> <00071122541602.00729@enzo.bigblue.local>
Subject: Re: trackpad
Date: Tue, 11 Jul 2000 17:09:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> All looks fine..., no idea what's going wrong for you. A new binary kernel
> will be on Ben's page in a hour or so, please try that one.
>
> Hmm, what procedure do you use to compile the kernel? If you use Ben's
> .config unchanged (no make config/xconfig/menuconfig), it should look like
> that:
>
>   make oldconfig dep clean vmlinux modules modules_install
>

Well, I've been using Linux on x86 for a couple of years now, so I usually
do this:

make xconfig (or menuconfig, depending on mood)
Change settings around (but this time I followed directions carefully on
what needed to be enabled)
make dep
make clean
make vmlinux
etc

I'll try the new kernel later this evening, when I get home from win-work.

Thanks,
Robbie Thompson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
