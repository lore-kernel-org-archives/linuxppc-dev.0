Date: Sat, 6 Dec 2003 13:11:44 -0600 (CST)
From: vinai <4_usenet@yahoo.com>
To: "LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: error compiling bttv
In-Reply-To: <p06020400bbf71e3a8e09@[192.168.0.23]>
Message-ID: <Pine.LNX.4.44.0312061309230.260-100000@kaiso.biophysics.mcw.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a shot in the dark, but do you have these options set in your
kernel?

# I2C support
#
CONFIG_I2C=y
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_KEYWEST=y
# CONFIG_I2C_CHARDEV is not set
# CONFIG_I2C_PROC is not set

Not sure which is required as I don't have video4linux myself ...

cheers
vinai


--
Vinai

To get my real e-mail address, replace "4" with "for" in the above address


On Sat, 6 Dec 2003, Stefan Jeglinski wrote:

> Trying to add video4linux. When I build for bttv, I get this error in
> the kernel compile:
>
> drivers/media/media.o(.text+0x12674): In function `bttv_remove':
> : undefined reference to `i2c_bit_del_bus'
> drivers/media/media.o(.text+0x12674): In function `bttv_remove':
> : relocation truncated to fit: R_PPC_REL24 i2c_bit_del_bus
> drivers/media/media.o(.text+0x13570): In function `init_bttv_i2c':
> : undefined reference to `i2c_bit_add_bus'
> drivers/media/media.o(.text+0x13570): In function `init_bttv_i2c':
> : relocation truncated to fit: R_PPC_REL24 i2c_bit_add_bus
> make: *** [vmlinux] Error 1
>
>
> Any ideas on a fix?
>
>
> Stefan Jeglinski
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
