Message-ID: <3DCBD57D.88FC5FA6@ardistech.com>
Date: Fri, 08 Nov 2002 16:17:17 +0100
From: "bart@ardistech.com" <bart@ardistech.com>
Reply-To: bart@ardistech.com
MIME-Version: 1.0
To: Christian Schroeder <christian.schroeder@imms.de>
Cc: linuxppc-embedded@lists.linuxppc.org, reklies@mazet.de,
	linz@mazet.de
Subject: Re: Microcode patching
References: <1036764594.3dcbc5b26bd42@imp.imms.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Christian,

Far the easiest way is to bit-bash the IIC with software and not use
the CPM for this. As pointed out earlier in the list there is not much
gained by using the CPM for IIC if your transfer sizes are small. Not
to speak of the many bugs in the algo-8xx driver.

Regards,
	Bart

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
>
> Greetings
> Christian Schroeder
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
