Date: Thu, 12 Oct 2000 22:49:38 +0200 (MET DST)
From: Albrecht Dress <adress@mpifr-bonn.mpg.de>
To: LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
cc: schmitz@opal.biophys.uni-duesseldorf.de, olh@suse.de
Subject: Re: 2.2.17pre20-ben3 + pmud-0.7-1: still kernel panic upon wakeup
In-Reply-To: <20001012213014.A29007@suse.de>
Message-ID: <Pine.SOL.4.21.0010122241340.21571-100000@mpifr-bonn.mpg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Oct 2000, Olaf Hering wrote:
> Can you try Benhs latest?
> http://penguinppc.org/~olaf/vmlinux-benh.gz

Got it, this one does not panic. I'll rsync from Ben's tree asap, thanks a
lot for your help! However, I recognised a quite odd behaviour of this
kernel: using the trackpad, the x and y coordinates are exchanged (moving
the trackpad up and down moves the cursor left and right and vice versa).
Not sure if this was caused by sleeping the machine (I reverted to my old
kernel as I doid not want to download the modules, too).

Thanks again, Albrecht.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
