Message-ID: <001f01c2fec6$94091c80$1464a8c0@sjeng3>
From: "El Topo" <ElTopo@myrealbox.com>
To: <erik.teose@exgate.tek.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <BA0E4392AD99D040885C414D992C24BE03615100@us-bv-m11>
Subject: Re: ppcboot 2.0.0 + ppclinux2.4.devel, network weirdo
Date: Wed, 9 Apr 2003 11:33:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Are you using kernel code supplied by MontaVista (MV)? I had the same
> problem;
> we are using MontaVista 3.0 for the Ebony board, and I had trouble with
> the interface from u-boot 0.2.0 to the MV kernel. The MV code is very
> specific to the bootrom supplied by IBM; that bootrom is "custom" to each
> unique Ebony board, because the 2 MAC addresses are stored at the end of
the
> bootrom (that's the "VPD" area). I had to modify 3 MV files to get the MAC
> address passed in from u-boot to be used by the MV kernel
> (kernel/arch/ppc/platforms/ebony.c,
> kernel/include/asm-ppc/ibm440.h, and kernel/include/asm-ppc/ibm4xx.h). I
> have attached
> my patches for these files.
>
> After I got the MAC address to transfer over from u-boot, I had trouble
with
> nfs mounting
> the root filesystem (I did not want to use bootp/dhcp in the nfs mounting
> process). I had to
> modify kernel/net/ipv4/ipconfig.c to get this to work (I've attached this
> patch as well).
>
> Hope this helps.
>
> Erik Teose
> erik.teose@tek.com

Thank you Erik, I will try your patchs today.

El.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
