Message-ID: <122201c3db3e$fa7c95f0$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
References: <115601c3dabc$06d9cdf0$3cc8a8c0@ANOSP> <1074126209.5123.22.camel@gaston>
Subject: Re: Ibook G4 modem
Date: Thu, 15 Jan 2004 09:10:03 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
> > Anyone knows what's the modem in the iBook G4 ? It doesn't even appear
in
> > `lspci` nor `lsusb`.
> > in the device-tree, however, there's an escc node (compatible:
> > "chrp,es0"), with ch-a and ch-b (but they have empty "slot-names").
> > There's also an i2c-modem node (compatible: "minidash2").
> >
> > Googling for minidash2 returns nothing...
> > Linuxant scripts to detect chipsets don't find anything, either.
> >
> > Anyone knows something about it ?
>
> The linuxant stuff should work. It's an USB modem. But it's only
> powered up when the USB driver is loaded ;)


Do you mean the ohci-hcd, or something else ? USB, i2c and modem related
modules I have are:

ohci_hcd               22048  0
ehci_hcd               28928  0
bsd_comp                6848  0
cdc_acm                11812  0
usb_storage           130676  0
usblp                  14368  0
i2c_keywest            13320  0
i2c_core               29540  3 therm_adt7467,i2c_keywest,snd_powermac

Thanks,
--
Colin
Ne disez pas disez, mais disez dites


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
