Reply-To: <tschaefer@giga-stream.de>
From: =?us-ascii?Q?Thomas_Schafer?= <tschaefer@giga-stream.de>
To: "Stephen Williams" <612dlag102@sneakemail.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: rpm for embedded system
Date: Thu, 8 Jul 2004 14:12:18 +0200
Message-ID: <FIEJJAKAABLMHFKFECNJCENDHBAA.tschaefer@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <21704-45627@sneakemail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

we are using the ipkg package management system, which is well suited for
embedded systems as it doesn't need much overhead on the system. A database
is used which takes a few kBytes (depending on the number of packages
installed) and the ipkg binary itself takes about 120kB on our PPC405 based
system. Furthermore, the package format is easy to understand (it is derived
from debian package format) and ipkg packages are easy to build.

For more detail, see

http://www.handhelds.org/z/wiki/BuildingIpkgs
http://www.handhelds.org/z/wiki/iPKG

There are more leightweight package management systems available, see

http://www.movial.fi/client-data/file/movial_package_management.pdf

Best regards,

Thomas Schafer

> -----Ursprungliche Nachricht-----
> Von: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]Im Auftrag von
> Stephen Williams
> Gesendet: Mittwoch, 7. Juli 2004 21:11
> An: linuxppc-embedded@lists.linuxppc.org
> Betreff: rpm for embedded system
>
>
>
> I'm using ELDK-3 from Denx for my ppc based board, which has
> disk space (in the form of a compact flash) that I want to
> manage using rpm. (I'd like to rpm install the eldk packages
> that I want on my target.)
>
> So I'm looking for a cross-rpm howto. Seems like the ppc_4xx-rpm
> that comes with the ELDK gets me half way there.
>
> --
> Steve Williams                "The woods are lovely, dark and deep.
> steve at XXXXXXXXXX           But I have promises to keep,
> http://www.XXXXXXXXXX         and lines to code before I sleep,
> http://www.picturel.com       And lines to code before I sleep."
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
