Message-ID: <3CB4ADC1.6070007@embeddededge.com>
Date: Wed, 10 Apr 2002 17:25:21 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Ron Bianco <ronb@junction.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 - Spurious interrupt when calling __sti()
References: <000b01c1e0cd$b8f02d30$4d012ac7@warp-speed>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ron Bianco wrote:

> For OpenPIC/EPIC hardware:

The 8260 family doesn't use EPIC.  It has a custom integrated controller.

Your point is taken that in general someone has to ensure devices and
interrupt controllers are properly initialized.  I thought I did this
in the kernel, but perhaps something was missed.  Sometimes, a boot rom
can leave something in a weird state (like the I2C for reading an EEPROM)
that the kernel doesn't always use.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
