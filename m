To: Borracini Evandro-R45188 <Evandro.Borracini@motorola.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: dynamically linked Init hanging 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 16 Oct 2001 14:55:18 -0300."
             <69AB2E42243FD511920200805FE64EAD0E3611@ZBR01EXM01>
Date: Tue, 16 Oct 2001 20:58:36 +0200
Message-Id: <20011016185841.2673110889@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <69AB2E42243FD511920200805FE64EAD0E3611@ZBR01EXM01> you wrote:
>
> Does any one know if glibc-2.1.3 from Linux/PPC 2000 Q4 can be used on a MPC860 target?

No, it cannot.

The MPC8xx has no FPU, and a smaller cache line size.

You need special libraries (with software floating point and  patches
for the cache line size) for the MPC8xx.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A supercomputer is a machine that runs an endless loop in 2 seconds.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
