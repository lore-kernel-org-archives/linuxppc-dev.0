Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: "Christian Schroeder" <christian.schroeder@imms.de>,
	<linuxppc-embedded@lists.linuxppc.org>
Cc: <reklies@mazet.de>, <linz@mazet.de>
Subject: RE: Microcode patching
Date: Fri, 8 Nov 2002 16:56:10 +0100
Message-ID: <IGEFJKJNHJDCBKALBJLLCEMJFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1036764594.3dcbc5b26bd42@imp.imms.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
>
> Hi all,
>
> I've got a question regarding the mpc8xx microcode patches in
> arch/ppc/8xx_io/micropatch.c. We do need usb host mode, i2c and
> ethernet operation at the same time. As I understood, i can't load
> the microcode patches for usb sof generation and iic/spi together,
> because they "live" at the same address. Now my question: What occurs
> if I don't load the ii2/spi patch. I do need the usb sof timing, but
> does the i2c-Interface work without the iic/spi patch ? As I read on
> the motorola webserver, the iic/spi is needed for concurrent operation
> of scc ethernet and i2c. Does i2c work correctly without the patch if
> I don't use ethernet ?

I2C will work fine without I2C microcode patch if you don't use ethernet on SCC1

Also, I submitted a new i2c-algo-8xx.c driver to this list about 2 weeks ago. It contains
sevral bug fixes and improvements. It's not in linuxppc BK yet, but I think it will be soon.

    Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
