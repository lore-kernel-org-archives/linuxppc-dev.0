Date: Sat, 30 Mar 2002 16:24:07 -0700
From: Matt Porter <mporter@mvista.com>
To: Neil Wilson <nwilsn@airspan.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: forcing pci device start address ?
Message-ID: <20020330162407.A5807@home.com>
References: <001201c1d80e$57e12840$479b883e@m5axc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001201c1d80e$57e12840$479b883e@m5axc>; from nwilson@airspan.com on Sat, Mar 30, 2002 at 05:14:24PM -0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Mar 30, 2002 at 05:14:24PM -0000, Neil Wilson wrote:
>
> Hi,
>
> We have a new 7450/107 board that I have got to boot and run 2.4.17.  The
> hardware designer has got some non-standard pci devices ie, a large fpga
>  that lives in pci space but does not have a configuration register and also
>  some standard pci devices like the AMD79C973 ethernet controller.

I don't understand.  It doesn't have "a configuration register".  Do
you mean that it does have any configuration space registers or that
it does not have BAR registers?  If it has BAR registers in config
space, do they respond to config cycles in the convential manner or
are they in a fixed position?  Please clarify so we can help you.

>  Is it possible to force the start address for the devices to be at specific
>  addresses as determined by the hardware map using the existing pci
>  controller code ?  An example is the ethernet controller which is at
>  0xe0000000 in the hardware map yet when it it is detected during the pci
>  probing the pcnet32 driver has its ioaddr set to somewhere like 0xfbeffxxx.
>
>
> I am looking through the other setups in the platforms directory and trying
>  to search the archives but this pci is all a bit of a mystery to me a the
>  momment.

We can help as well as the info you give us. :)

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
