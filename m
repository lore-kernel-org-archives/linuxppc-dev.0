Message-Id: <4.3.2.20010309071330.00bd6b60@falcon.si.com>
Date: Fri, 09 Mar 2001 07:21:30 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: How to get COFF-format code
In-Reply-To: <3AA8A8EE.1C1A8149@fiberlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


objcopy should be able to do this (it does everything else!), just
specify that the output format be coff (ecoff?).  I have not actually
done this, so I'll leave it as an exercise to determine the proper set
of flags.

objdump -i      # list known target formats
objcopy -h      # help: last line shows supported target formats

If *coff* is listed, you are in luck.  If not, it will be some more
work (I'm sure that was an understatement :-).

My reference linux system is x86 and doesn't support coff.  Your
mileage may vary.

gvb


At 05:57 PM 3/9/01 +0800, Lin, Nan-Hung wrote:

>Hello,
>
>I use linux-2.4.0-test13-pre2 and
>       Processor Type as 8xx
>       Machine Type as   TQM855L
>
>The "make" only generates ELF-format code.
>How to generate COFF-format code ?
>
>Thanks for help.
>
>
>------------------------------------------
>Carl Lin               carl@fiberlogic.com
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
