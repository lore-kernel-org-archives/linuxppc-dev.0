Date: Thu, 28 Sep 2000 23:31:19 +0200
From: Claus <cl.en@gmx.net>
To: R Shapiro <rshapiro@bbn.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: beige g3 rage II xf4.0.1 and miBoot
Message-ID: <20000928233119.B334@olis.north.de>
Reply-To: cl.en@gmx.net
References: <14803.24024.683420.911271@esb.bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <14803.24024.683420.911271@esb.bbn.com>; from rshapiro@bbn.com on Thu, Sep 28, 2000 at 11:03:52 -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 >: I plan to try quik-booting as soon as I can figure out the boot-device
 >: syntax for ide drives (I've only configured quik-booting on scsi up


when you're in OF a 'devalias' should do it
or check /proc/device-tree/aliases/

mine internal IDE wants
boot-device = ata0/ata-disk@0:x (x=root in hex,)
boot-file = /boot/vmlinux (+ kernel options)



		Claus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
