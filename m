Message-ID: <3AB9148A.7F25E9A0@mvista.com>
Date: Wed, 21 Mar 2001 15:52:26 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Cc: Frank Rowand <frank_rowand@mvista.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	frank@esd-electronics.com
Subject: Re: possible problem in memory management
References: <3AB8B894.1C5FCD37@esd-electronics.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matthias Fuchs wrote:

>   CPU:   IBM PowerPC 405GP Rev. C at 198 MHz (PLB=99, OPB=49, EBC=33 MHz)

Get yourself an up to date Rev. D CPU.  The Rev. C workarounds in
the kernel were reasonable attempts, but probably aren't complete.
Since the Rev. D fixes all of these problems, we stopped debugging
all of the little Rev. C problems because they were just too time
consuming.

You also need specially patched user libraries for anything older
than Rev. D, and you can't use these patches libraries on Rev. D,
so we stopped supporting that as well and simply suggest (require)
the upgrade to the working Rev. D silicon.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
