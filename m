To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded MPC860T & flash memory 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 22 Feb 2002 15:26:00 +0100."
             <3C7654F8.3010801@capflow.com>
Date: Fri, 22 Feb 2002 16:16:48 +0100
Message-Id: <20020222151653.25BED109E2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Laurent,

in message <3C7654F8.3010801@capflow.com> you wrote:
>
> As I need to be able to write to the memory using the MTD layer, I was
> wondering if it would be better to use 2 16-bit wide chips in
> interleaved mode on a 32-bit bus (connecting them in parallel to the
> bus, one of them storing D[0:15] and the other one D[16:31]), or to use
> them in non-interleaved mode (non-overlapping address ranges) on a
> 16-bit bus. It seems that the Linux MTD layer can support both
> configurations, but I don't have a deep knowledge of that code, and thus
> would appreciate any advice.

For the software it does not matter - both configurations will work.

For the performance it makes a BIG difference.

Go for a buswidth of 32 bits, i. e. use 2 chips in 16 bit mode in
parallel.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The trouble with doing something right the first time is that nobody
appreciates how difficult it was."                        - Walt West

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
