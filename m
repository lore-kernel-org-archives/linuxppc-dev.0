Mime-Version: 1.0
Message-Id: <v04210104b45097a0f485@[192.168.0.1]>
In-Reply-To: <9911111547.AA37258@marc.watson.ibm.com>
References: <9911111547.AA37258@marc.watson.ibm.com>
Date: Thu, 11 Nov 1999 07:01:27 -0900
To: David Edelsohn <dje@watson.ibm.com>, "Florent" <flobo@iname.com>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: Re : Newworld OF boot
Cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 11/11/99 David Edelsohn wrote:

>	What is the requirement for the OF booter reading the kernel from
>a filesystem?  AIX piggybacks the kernel on the OF booter itself.  The
>entire file is loaded by OF and then the booter decompresses and/or copies
>the kernel to the location from which it takes control and relocates
>itself to its final destination.  This may not be perfect, but it avoids
>the problems of teaching the OF booter how to read partions and
>filesystems.

because you have to recompile your booter every time you recompile 
the kernel, or keep the kernel in a nonstandard location.

also ultimately it would be nice for the booter to support multiple 
images, if the loader does not support the root filesystem you have 
to make this silly boot partition much larger then it need be.

if reading right from the ext2fs can be done it would simply be much 
nicer that way.

it should be possible since even apple managed to do it with their 
version of BootX (OSXS loader)



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
