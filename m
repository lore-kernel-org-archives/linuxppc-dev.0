Message-ID: <1148.62.166.230.82.1067673460.squirrel@www.chez-thomas.org>
In-Reply-To: <BAY9-F64QUsi6dnG8Cq0008719d@hotmail.com>
References: <BAY9-F64QUsi6dnG8Cq0008719d@hotmail.com>
Date: Sat, 1 Nov 2003 00:57:40 -0700 (MST)
Subject: Re: Linux boot args with PReP image
From: "Gary Thomas" <gary@mlbassoc.com>
To: "Ashwin Bihari" <raz0redge@hotmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ashwin Bihari said:
>
> Greetings,
>
> I'm using a PrPMC800 with Motorola's PPC7-BUG> to boot Linux. I've got a
> working kernel and everything works fine. I've used the default boot args
> of: console=ttys0,9600 console=tty0 root=/dev/hde2 noinitrd.
>
> This, of course, means that if we decide to change the location of root, or
> more appropriately decide to have two separate roots between which we would
> have switch back and forth, I'll have to recompile the kernel with the new
> string and then put that onto the PReP partition.
>
> What I would ideally like to do is have a Linux: prompt appear after I boot
> into the PReP partition to allow me to have a default string and then change
> it if I decided to chagne root on the fly..
>
> Has anyone done anything similar or have any tips for me?

This is SOP for the embedded boards.  Look at arch/ppc/boot/embedded for
some guidelines on how to do it.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
