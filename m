Message-ID: <3FAA6106.7020204@embeddededge.com>
Date: Thu, 06 Nov 2003 09:56:06 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC as serial console on 8260
References: <37D0F88E70D96C428C19EEB865701A3801DC62E6@buda902a.siemens.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mészáros Lajos wrote:

> Can we use the SCCs as console on 8260
> based boards? (2.4.18 and 2.4.22)

Yes, but the driver is in the linuxppc_2_4_devel kernel
from bitkeeper.  I'm working on moving this and many
other things from this kernel into the standard baseline.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
