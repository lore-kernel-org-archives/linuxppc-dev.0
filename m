Message-Id: <4.3.2.20010309072224.00c05100@falcon.si.com>
Date: Fri, 09 Mar 2001 07:23:26 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: How to get COFF-format code
In-Reply-To: <3AA8A8EE.1C1A8149@fiberlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hey, look at that.  Tornado-2 (gcc-based) cross compiler supports a
flavor of coff:

C:\tmp>objdumpppc -i
BFD header file version cygnus-2.6
elf32-powerpc
  (header big endian, data big endian)
   powerpc:common
aixcoff-rs6000
  (header big endian, data big endian)
   powerpc:common
   rs6000:6000

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
