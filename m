Date: Tue, 14 Oct 2003 17:10:43 -0500
Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppcdev <linuxppc-dev@lists.linuxppc.org>
To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
From: Ken Offer <koffer@arlut.utexas.edu>
Message-Id: <40CB1A40-FE93-11D7-AB64-000393467F1A@arlut.utexas.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Date: 11 Oct 2003 23:44:22 +0200
> From: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
> Subject: Re: Need a Linux PPC kernel which supports the Radeon
> Mobility 9600
>
> Hi,
>
> Benjamin Herrenschmidt writes:
>
>> I just fixed that in my 2.6 and I'll backport to 2.4 soon
>
> I compiled the latest version of that tree in order to get radeonfb
> working on my 17" Powerbook.  A few questions:

Hi Jens,

I'm trying that myself, but I'm running into undefined symbols, plus
problems with compiling PCNET32 (whatever that is).

I started with the ".config" file copied from
"arch/ppc/configs/pmac_defconfig", but that might not be the best.  I'm
not sure how all the creative config names map to specific machines,
like the PowerBook.

What config file did you compile 2.5-benh with?

+--------------------------------------------------------------+
| Ken Offer                               Office: 512-835-3859 |
| Email: koffer@arlut.utexas.edu             Fax: 512-835-3259 |
| Applied Research Laboratories, University of Texas at Austin |
+--------------------------------------------------------------+


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
