Message-ID: <3EBC39AA.20501@esteem.com>
Date: Fri, 09 May 2003 16:28:42 -0700
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: rblach@intrex.net
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What PCI specs will I need?
References: <3EBAD545.50707@esteem.com> <3EBAE381.5080602@intrex.net> <3EBAF516.8080300@esteem.com> <3EBAF7A1.7090903@intrex.net>
In-Reply-To: <3EBAF7A1.7090903@intrex.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
> Conn,
>
> The first thing to ask is what you want your bios to do? If you are
> making an adapter card,
> it will be much different than if you are. Linux for mot and IBM  have a
> pretty complete pci scan.
>
We will be building a small system that was two (mabey three) mini-PCI
slots.


> IBM supplies an open bios that also scans the PCI and does some setup.
>
> 1)will you have fixed devices on your device.  This makes pci setup much
> simpler.
> 2)pci is not that hard if you have a fixed number of devices.  A
> generalized pci scan
>   is very difficult.
>

Our system will only contain devices we choose to stick in it, so mabey
a complete scan isn't needed.


> Heres a books you can get from amazon.com
>
> PCI System Architecture (4th Edition) -- by Tom Shanley, et al; Paperback
> PCI & PCI-X Hardware and Software (Architecture and Design) -- by Ed
> Solari; Hardcover

Do either of these books contain all of the electrical characteristic
details ( such as impeadance, capacitiance, bus loading, etc) ?

> By the I work for IBM and have extensive experience with the 405. I have
> not worked with
> the Mot parts but to fair, I have very good things about it.
>

The IBM 405GP is not out of the running yet. If they had one with PCI,
an SPI, an I2c, two serial ports, and two 10/100Mbps ethernet ports it
would have won hands down for our aplication.


> You can get hardware questions answered about the 405 by contacting
> ppcsupp@us.ibm.com
>

Thats handy.




> MontaVista does the linux for both.
>
> Chip
>
>
>
> Conn Clark wrote:

<snip>

>> Conn
>>
>
>
>
>

Thanks for the input

	Conn

--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
