Message-ID: <399082CA.1DA9D0D1@embeddededge.com>
Date: Tue, 08 Aug 2000 17:59:38 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
CC: "'Dan Malek'" <dan@netx4.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Serial Port Baud Rate
References: <BE1C564723B3D21191FD0000F840E39801D815F8@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" wrote:
>
> Baud rates 300, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200 worked
> for me, with simple tests.

Thanks (I was mostly giving you a hard time, but I do appreciate the
testing :-).

> The lower Baud rates lose characters when the device is closed before it has
> been emptied, but that's a known condition which is usually not a problem
> for embedded work.

Yeah.  Unfortunately, there isn't any way to know when the last bit of
the UART has left the CPM shifter.  The only method is to delay based upon
the FIFO depth and bit rate.  That obviously isn't implemented very well.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
