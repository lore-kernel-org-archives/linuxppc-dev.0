Message-ID: <3AD21837.D8AEA7E4@mvista.com>
Date: Mon, 09 Apr 2001 16:14:47 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: nunninger@web.de
Cc: linuxppc-embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to debug ethernet
References: <3AD1B33D.439A45D2@enst.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stefan Nunninger wrote:

> To do so I changed the file /arch/ppc/8xx_io/commproc.h  the values
> for
> ethernet (SCC1) as follows:
>

> #define PA_ENET_TCLK    ((ushort)0x0200)      /* Pin  6 Port A */
> #define PA_ENET_RCLK    ((ushort)0x0100)      /* Pin  7 Port A */

Your TCLK/RCLK pair doesn't match any existing configuration, so you
must also change the SICR_ENET_CLKRT value.  I didn't see this in
the code you listed, so if you didn't change it, this will be
part of the problem.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
