Subject: Re: mii-tool support for gmac/sungem
From: Bastien Nocera <hadess@hadess.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <3D8E88DF.2000900@mandrakesoft.com>
References: <1032740384.13093.199.camel@dozo>
	<3D8E88DF.2000900@mandrakesoft.com>
Content-Type: text/plain
Date: 23 Sep 2002 10:09:07 +0100
Message-Id: <1032772148.4083.75.camel@bnocera.surrey.redhat.com>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2002-09-23 at 04:22, Jeff Garzik wrote:
>
> Bastien Nocera wrote:
> > Hello,
> >
> > I wanted to know if mii-tool was supposed to work with the gmac/sungem
> > card in the iBook2 laptops. I tried it out:
> >
> > $ sudo mii-tool
> > SIOCGMIIPHY on 'eth0' failed: Operation not supported
> > SIOCGMIIPHY on 'eth1' failed: Operation not supported
> > no MII interfaces found
> >
> > I see code for this ioctl in the kernel though in gem_ioctl
> > (drivers/net/sungem.c) and some messages that seem relevant in dmesg:
> >
> > eth0: MII PHY ID: 4061e0 BCM 5221
> > eth0: switching to forced 100bt
> > eth0: switching to forced 10bt
> > etc.
> >
> > Any ideas ?
>
>
> use ethtool...

Rock, it works. Does ethtool work for every card for which the driver
has an MII interface ?

Thanks

--
/Bastien Nocera
http://hadess.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
