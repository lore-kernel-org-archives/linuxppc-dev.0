Message-ID: <3D8EE384.3030503@mandrakesoft.com>
Date: Mon, 23 Sep 2002 05:48:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mii-tool support for gmac/sungem
References: <1032740384.13093.199.camel@dozo> 	<3D8E88DF.2000900@mandrakesoft.com> <1032772148.4083.75.camel@bnocera.surrey.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Bastien Nocera wrote:
> On Mon, 2002-09-23 at 04:22, Jeff Garzik wrote:
>
>>Bastien Nocera wrote:
>>
>>>Hello,
>>>
>>>I wanted to know if mii-tool was supposed to work with the gmac/sungem
>>>card in the iBook2 laptops. I tried it out:
>>>
>>>$ sudo mii-tool
>>>SIOCGMIIPHY on 'eth0' failed: Operation not supported
>>>SIOCGMIIPHY on 'eth1' failed: Operation not supported
>>>no MII interfaces found
>>>
>>>I see code for this ioctl in the kernel though in gem_ioctl
>>>(drivers/net/sungem.c) and some messages that seem relevant in dmesg:
>>>
>>>eth0: MII PHY ID: 4061e0 BCM 5221
>>>eth0: switching to forced 100bt
>>>eth0: switching to forced 10bt
>>>etc.
>>>
>>>Any ideas ?
>>
>>
>>use ethtool...
>
>
> Rock, it works. Does ethtool work for every card for which the driver
> has an MII interface ?


not yet... I still need to add fallback code to ethtool, that lets it
speak low-level MII [older drivers] as well as the newer ethtool [newer
drivers].

	Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
