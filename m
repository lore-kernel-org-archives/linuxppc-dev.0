Message-ID: <402EA47B.2010600@lucent.com>
Date: Sat, 14 Feb 2004 15:43:07 -0700
From: Mike Wellington <wellington@lucent.com>
MIME-Version: 1.0
To: Jon Masters <jonathan@jonmasters.org>
Cc: linuxppc-embedded@lists.linuxppc.org, wellington@lucent.com,
	mike@lo-ex.com
Subject: Re: ml300 boot loader question
References: <20040211214947.87373.qmail@web21110.mail.yahoo.com> <402CEC30.9060503@xilinx.com> <402E2841.9020700@jonmasters.org>
In-Reply-To: <402E2841.9020700@jonmasters.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All I know is that Xilinx customer support told me that EDK 3.2 and
EDK 6.1 are incompatible with each other.   Also be sure to get the
service packs for EDK 6.1 and ISE 6.1.   Inside the service packs
was a utility called "revup" which I used to convert my "pre-service pack"
designs to run under 6.1+Service Pack.  I think there are instructions
on the Xilinx website where you find the Service Pack telling you how
to upgrade your designs.

-mike wellington
  wellington@lucent.com



Jon Masters wrote:

>
>
> Peter Ryser wrote:
>
> | downloads the Linux kernel into main memory, and boots Linux.
>
> Has anyone here had problems with designs that work fine when built with
> EDK 3.2 subsequently falling over completely with EDK 6.1?
>
> At the moment I am debugging a possible issue with memory controller
> logic and would love to hear these are known issues with fixes.
>
> Cheers,
>
> Jon.
>
>



--

=mike wellington
wellington@lucent.com
303.920.6412  Desk
720.434.7559  Cell


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
