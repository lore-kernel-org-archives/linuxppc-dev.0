Message-ID: <39579763.365AE86E@snmc.com>
Date: Mon, 26 Jun 2000 12:48:19 -0500
From: Daris Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: Manie Steyn <msteyn@wmux.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC support
References: <NEBBIKAICMIJKJMMELBFKELBCAAA.msteyn@wmux.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Manie,

The message "neighbour table overflow" is the result of some
changes to the IP stack software in Linux version 2.2.x +. This
simply means that you are unable to connect to your NFS
server.  It may be related to the driver, but it may also be
related to other issues, such as NFS server not running or
incorrectly installed, no physical connectivity to NFS server,
etc.  Check the configuration of your NFS server and IP
network before diving into the driver.

Daris Nevil
SiSIC Inc/SNMC
www.snmc.com

Manie Steyn wrote:

> Hi,
>
> I am running the Embedded Planet Classic 860T with Monta Vista's 2.2.13
> kernel and have some trouble in getting the FEC interface up and running.
>
> The "link" LED comes on but after using ifconfig to assign an IP, I get
> "neighour table overflow" when pinging to or from the device.
>
> I saw the following mail from Dan regarding the 2.4 tree:
>
> > >>> "dan@netx4.com" 06/08/00 20:56 >>>
>
> > I merged a ton of changes into the FEC driver from Magnus, Graham,
> > and myself for generic PHY support.  Don't even think about complaining
> > that this doesn't yet work.  I know it doesn't.
>
> Does this also hold for the FEC driver in the 2.2.13 port, or am I doing
> something wrong?
>
> Regards
> Manie Steyn
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
