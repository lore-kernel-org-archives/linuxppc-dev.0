Date: Sat, 14 Jul 2001 01:02:38 +0200
From: Olaf Hering <olh@suse.de>
To: Leigh Brown <leigh@solinno.co.uk>
Cc: tom_gall@vnet.ibm.com, tinglett@vnet.ibm.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Booting 43P-140
Message-ID: <20010714010238.A4742@suse.de>
References: <3B4DCAAD.72D18C80@vnet.ibm.com> <34295.192.168.1.2.995062780.squirrel@fridge.bcc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <34295.192.168.1.2.995062780.squirrel@fridge.bcc.co.uk>; from leigh@solinno.co.uk on Fri, Jul 13, 2001 at 11:19:40PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 13, Leigh Brown wrote:

>
> Thanks Tom and Todd!  Updating to the latest firmware did the trick.
> I can now boot both the SuSE kernel and even my homebrew 2.4.7pre4.
>
> Unfortunately, the SuSE kernel doesn't match the ramdisk on their site
> so I can't load a network card driver to complete the installation.
> I'll have to build my own 2.4.1 kernel and ramdisk to complete the
> SuSE install, unless anyone has any other ideas?

compile either the pcnet32 or tulip driver into the kernel.

what kernel source tree is that 2.4.7pre4?

Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
