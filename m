Message-ID: <39DB8BB4.A1DB8B50@mvista.com>
Date: Wed, 04 Oct 2000 15:57:40 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: ajay.kunnath@exgate.tek.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IIC write
References: <21F9768AF088D211BF1C0008C71E5786013C9E07@ap-bang-m02.india.tek.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ajay.kunnath@exgate.tek.com wrote:

> As per the manual, I need to mention the device address as the first byte to
> be transmitted i.e. first byte in tbdf->cbd_bufadr . If so, where do I
> mention
> the actual buffer which contains the data that needs to be written to the
> EEPROM ?

In the same buffer following the device byte, or in a following BD
when the buffer containing the device byte does not have the last (L)
indicator in the BD control/status.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
