Message-ID: <3D8E88DF.2000900@mandrakesoft.com>
Date: Sun, 22 Sep 2002 23:22:07 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mii-tool support for gmac/sungem
References: <1032740384.13093.199.camel@dozo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bastien Nocera wrote:
> Hello,
>
> I wanted to know if mii-tool was supposed to work with the gmac/sungem
> card in the iBook2 laptops. I tried it out:
>
> $ sudo mii-tool
> SIOCGMIIPHY on 'eth0' failed: Operation not supported
> SIOCGMIIPHY on 'eth1' failed: Operation not supported
> no MII interfaces found
>
> I see code for this ioctl in the kernel though in gem_ioctl
> (drivers/net/sungem.c) and some messages that seem relevant in dmesg:
>
> eth0: MII PHY ID: 4061e0 BCM 5221
> eth0: switching to forced 100bt
> eth0: switching to forced 10bt
> etc.
>
> Any ideas ?


use ethtool...

	Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
