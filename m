Message-ID: <005d01c2c837$70018720$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "Junping Zhang" <JZhang@erinc.com>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
References: <F4608F665DF5D311B231009027B70F700155D4D2@MAIL>
Subject: Re: question on mcc driver
Date: Thu, 30 Jan 2003 09:13:13 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>    Do you have some test programs for MPC8260 mcc driver that I can use? I

The driver itself does not need a particular code to be tested. Once it has
been loaded,the function module_init() provides to initialize the MCC1 on
the two TDMs C1 & D1. The interrupt handler is responsible of re-loading the
BDs after the completion of receiving process.
Obviously You must check it with an oscilloscope and verify that all the
signal needed by the MCC are active.

Be aware that all the I/O pins and accessories functions have been
previously programmed, because the driver does not provide any configuration
of the I/O neither than clocks routing

> managed to compiled
> and loaded your driver, but seems like it has some conflicts with Pete's
ATM
> driver, once I load
> ATM driver, mcc driver won't load; if I load mcc driver first, then ATM
> driver, mcc driver won't unload.

We have succesfully tested the driver with both M.V. 2.4.0-test2 (by Linux
CDK 1.2) and 2.4.4 (by ELDK 2.0.2), but unfotunately We did not implemented
any ATM driver.

Regards

Ing.Gianfranco Morandi
Eurostudio s.r.l.
Rome Italy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
