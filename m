To: "Johnson, Stephen" <stevebj@artesyncp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Opps...with ELDK-2.1.0 (ppc_4xx) 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Apr 2003 10:59:07 CDT."
             <F9102D41F595D311ACA7009027DE2C840527B190@c3po.heurikon.com>
Date: Tue, 22 Apr 2003 18:58:27 +0200
Message-Id: <20030422165832.70DDDC58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <F9102D41F595D311ACA7009027DE2C840527B190@c3po.heurikon.com> you wrote:
>
> I've been using the ELDK-2.0.2 with the same kernel (2.4.21) and it has been very stable (uptime of ~4 months). I installed the ELDK-2.1.0 and mounted it (using the same kernel) and I'm observing an "Oops" after several minutes (~10 minutes or so).

Is  this  really  the  same  kernel  source  tree,  using  the   same
configuration?  The  only  part  of the ELDK which gets involved with
building the kernel is the compiler, and there  were  no  changes  in
that area.

> I'll be digging through the logs for clues.
>
> ----
> Oops: Exception in kernel mode, sig: 4

What was the last you did before that? Are you running from root over
NFS, or ramdisk, or what?

> Call backtrace:
> C000F2DC C000F1EC C000FCEC C00DC510 C00DC860 C00DCF74 C00DA7A0
> C00DB5CC C00DB720 C00DB110 C00DD664 C00DD7E4 C0004F04 C000376C
> C00228C8 C0004D04 C0004D2C C00011D0 C0181598 C0000224

Maybe you could try and decode the backtrace?

See Documentation/oops-tracing.txt,  or  simply  pipe  the  backtrace
output through our backtrace script (ftp://ftp.denx.de/pub/tools/backtrace)


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I think there's a world market for about five computers.
         -- attr. Thomas J. Watson (Chairman of the Board, IBM), 1943

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
