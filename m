From: benh@kernel.crashing.org
To: Marcus Metzler <mocm@metzlerbros.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Again with the firewire
Date: Wed, 21 Nov 2001 19:27:16 +0100
Message-Id: <20011121182716.31026@mailhost.mipsys.com>
In-Reply-To: <15355.53673.64916.328240@sheridan.metzler>
References: <15355.53673.64916.328240@sheridan.metzler>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Hi,
>I don't know if you guys remember, but I posted about my problems with
>my tibook and the firewire port a while ago. At that time the firewire
>was broken in such a way that I couldn't boot into any MacOs anymore
>and it crashed when insmodding the ohci1394 module.
>Since then I had Apple take the notebook and repair it, which took
>almost 3 weeks. After that firewireworked with MacOS X and 9.1 and I
>didn't try it with Linux for a while.
>
>Yesterday, I used the kernel-dev tree to build a new kernel with
>firewire modules. The modules had some missing dependencies, so I took
>the latest CVS from linux1394 which compiled fine and had no missing
>dependencies. I modprobed ohci1394 and sbp2 and it didn't work. I
>tried rescan-scsi-bus.sh and still nothing. So I tried loading and
>unloading the mordules a couple of times until got an error from
>get_phy_reg.
>After that I gave up and wanted to see if MacOS still worked.
>And, although I could still boot both MacOSs, as soon as I plug in the
>firewire drive the system hangs. Unplugging the drive unfreezes the
>system, but I couldn't get rid of the behaviour, even with
>all the resets you guys told me the last time. Seems like it's broken
>again. The firewire disk mode also doesn't work. This one freezes my
>linux PC until I unplug the tibook.
>My question is, how can the firewire chip get broken by software and
>why can't it be reset? I had crashes of the Linux driver with my
>desktop PC and Sony notebooks, but nothing like that ever happened there.
>I guess Apple won't repair my tibook a second time, so I have to live
>without firewire on the tibook, which otherwise is really great.

Ask Apple what they did ... their chipset isn't documented and they
didn't opensource their firewire driver for it.

Note that working firewire for pismo/tipb exist in my rsync tree
or in the linux1394 CVS. Linus and bk _devel aren't up-to-date yet.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
