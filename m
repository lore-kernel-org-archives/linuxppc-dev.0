Message-ID: <3CBD321A.60CE328@imc-berlin.de>
Date: Wed, 17 Apr 2002 10:28:10 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Dan Malek <dan@embeddededge.com>
Subject: MPC8xx and IDMA !?!?
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,,

a while ago (aprox. kernel 2.4.11) I succesfully played around with IDMA
on MPC855/860.

This old kernel is still working on my hardware.

BUT:

The code is NOT working on recent kernels (I pulled it yesterday).

I set up the IDMA. Trigger DREQ0 using a GPIO pin. SDMACK1 is going LOW
but then instead of toggeling it just stays LOW. And instead of
transfering data the MPC8xx just hangs.

Have there been changes to the DMA stuff in the MPC8xx?
Or in the DPRAM layout or maybe in the CPM interrupt stuff (although I
disabled the IDMA int.) ???

Any idea and/or help is very much appreciated!

Thanks,

Steven





--
mfg Steven Scholz

imc Meﬂsysteme GmbH
Voltastr. 5
13355 Berlin
Germany
fon: +49 30 467090-0
fax: +49 30 4631576

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
