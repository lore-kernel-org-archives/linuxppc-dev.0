From: "dong in kang" <dkang@east.isi.edu>
To: "'Omanakuttan'" <omanakuttan@tataelxsi.co.in>,
	<greggiraud@netcourrier.com>, <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: use bdi2000
Date: Wed, 9 Jul 2003 17:34:17 -0400
Message-ID: <001b01c34661$dbed2630$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3F0BFC93.3080801@tataelxsi.co.in>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Actually, I also have the same problem.
I tried to use SOFT break, and the problem seems to disappear.
Am I doing right?

 Here is my configuration file.

BREAKMODE SOFT
MMY  XLAT
BDIMODE  AGENT

 Thanks,

 Dong-In



-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of Omanakuttan
Sent: Wednesday, July 09, 2003 7:29 AM
To: greggiraud@netcourrier.com; linuxppc-embedded@lists.linuxppc.org
Subject: Re: use bdi2000



greggiraud@netcourrier.com wrote:
> Hi,
> I have some problem with the use of the bdi 2000 to debug linux kernel
> with DDD. In fact, I am connecting to the bdi2000 (target remote ....).
And then, if I do step by step. But When I click  on "step", DDD print: "
error accessing memory access". And then, when I click again on "step" it
steps. Is it normal???
seems like you have not enabled MMU XLAT in the configuration file of bdi.
check if the .cfg file contains the following lines, whithout an initial
semi colon.
MMU         XLAT        ;translate effective to physical address


Regards,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
