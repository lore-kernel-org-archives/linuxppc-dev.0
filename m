Subject: Re: how to log in shell from jffs2?
From: David Woodhouse <dwmw2@infradead.org>
To: Michael Hao <linux_powerpc@hotmail.com>
Cc: wd@denx.de, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <BAY13-F56DM2gvKTs1L00023e8b@hotmail.com>
References: <BAY13-F56DM2gvKTs1L00023e8b@hotmail.com>
Content-Type: text/plain
Message-Id: <1085731718.27156.4528.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Date: Fri, 28 May 2004 09:08:38 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2004-05-25 at 09:12 +0800, Michael Hao wrote:
> jffs2_scan_empty(): Empty block at 0x0064ffec ends at 0x00650000 (with 0x1985e002)! Marking dirty

Harmless message complaining that you didn't give a correct '-e'
(erasesize) option to mkfs.jffs2 when the image was created.

It's OK to build an image with an erasesize smaller than the actual
hardware as long as you don't include cleanmarkers though.

> I have asked this is why, I change a filesystem and make jffs2,it also
> likes this?

Do you include /dev in your file system or was it designed with devfs in
mind?

--
dwmw2


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
