Subject: Re: error compiling bttv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: vinai <4_usenet@yahoo.com>
Cc: "LinuxPPC Developers' List" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.LNX.4.44.0312061309230.260-100000@kaiso.biophysics.mcw.edu>
References: 
	 <Pine.LNX.4.44.0312061309230.260-100000@kaiso.biophysics.mcw.edu>
Content-Type: text/plain
Message-Id: <1070760204.12497.23.camel@gaston>
Mime-Version: 1.0
Date: Sun, 07 Dec 2003 12:23:24 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-12-07 at 06:11, vinai wrote:
> Just a shot in the dark, but do you have these options set in your
> kernel?
>
> # I2C support
> #
> CONFIG_I2C=y
> # CONFIG_I2C_ALGOBIT is not set
> # CONFIG_I2C_ALGOPCF is not set
> CONFIG_I2C_KEYWEST=y
> # CONFIG_I2C_CHARDEV is not set
> # CONFIG_I2C_PROC is not set
>
> Not sure which is required as I don't have video4linux myself ...

Actually, looking as his errors, I think what he needs is
CONFIG_I2C_ALGOBIT = y

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
