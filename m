Mime-Version: 1.0
Message-Id: <v04210106b4509b58d458@[192.168.0.1]>
In-Reply-To: <9911111606.AA37454@marc.watson.ibm.com>
References: <9911111606.AA37454@marc.watson.ibm.com>
Date: Thu, 11 Nov 1999 07:13:33 -0900
To: David Edelsohn <dje@watson.ibm.com>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: Re : Newworld OF boot
Cc: "Florent" <flobo@iname.com>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 11/11/99 David Edelsohn wrote:

>
>	One does not need to recompile the booter, only rebuild the boot
>file with new piggyback information.

whatever

>If one piggybacks the kernel then
>network booting becomes much simpler because the file loaded via BOOTP
>contains all of the information to boot into the kernel.

fine why can't we do it both ways? for local installs its more 
convenient to have the kernel in the standard place on a ext2fs, for 
netboots its easier to piggy back it, support both and we have an 
ideal bootloader.



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
