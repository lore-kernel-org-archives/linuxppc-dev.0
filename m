Message-ID: <3AFFE425.41DC6622@snmc.com>
Date: Mon, 14 May 2001 08:56:53 -0500
From: Daris A Nevil <dnevil@snmc.com>
MIME-Version: 1.0
To: "Brown, David (dbrown03)" <DBrown03@harris.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Synchronous serial?
References: <BE1C564723B3D21191FD0000F840E39804475AB1@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi David,

I'm a little hesitant to mention this, because I have been flamed for
referring to code in older kernels, but here goes :-)

I developed an HDLC/PPP driver for kernel 2.2.5 for the MPC850.  The
code is GPL'd, so you are welcome to use it, or use at it as an
example.  I have been informed by people at other companies that this
driver is used to interface to CISCO routers.  It has been used on
boards other than our own QS850.  It makes use of the syncppp.c module
in the standard kernel.  I developed the HDLC portion for the SCC's.

There is some porting work involved, because we use some subsystems we
developed that have not been folded into the 2.4 kernel (namely I/O
setup), but it should only be trivial work (we use Dan Malek's include
files for CPM register definitions, Thanks Dan!).

The source can be downloaded from ftp://qslinux.org, and there should be
some documentation on http://qslinux.org.

If you do port this code to Kernel 2.4 then let me know.  Perhaps we can
work together to get it folded into the latest PowerPC kernel for others
to use, as there is interest in it from time to time.

Regards,
Daris Nevil
SNMC


"Brown, David (dbrown03)" wrote:
>
> I'd like to interface an 860 with equipment that uses synchronous serial.
> I've done this before with other embedded operating systems.  I'm wondering
> if the Linux drivers for the SCC support synchronous?
> -- Dave Brown <dbrown03@harris.com>
>

--
Daris A Nevil
Simple Network Magic Corporation
401 Kentucky Lane
McKinney, TX 75069
214-793-7757
dnevil@snmc.com
www.snmc.com
quickstack.com
qslinux.org

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
