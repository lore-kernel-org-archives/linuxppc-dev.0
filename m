To: "Yang, Bo" <bo.yang@transcore.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: serial console lost when linux kernel boots up 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Apr 2003 13:49:54 MDT."
             <406B9D084FAFD4118C980008C79FADB901B57FF4@ALBMAIL>
Date: Fri, 11 Apr 2003 22:21:02 +0200
Message-Id: <20030411202107.AFFA8C5877@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <406B9D084FAFD4118C980008C79FADB901B57FF4@ALBMAIL> you wrote:
>
> I am trying to run linux kernel (Linux version 2.4.4 downloaded from DENX)
> on MPC8XXFADS (CPU:860T) board. The root file system is mounted via NFS.
> The root file system I used is the one coming with DENX's ELDK package (I
> use ELDK cross compile tools).
>
> The problem is that once the linux kernel boots up I lose serial
> console(e.g. no loggin prompt). There is one warning message as the last
> printout on my console terminal:
> "Warning: unable to open an initial console". I look at the root file system
> on my host linux box and found out that there is no device file populated
> under "opt/eldk/ppc_8xx/dev".
> I wonder the root file system I used may not be a complete file system. Any
> ideas? Thanks for any hints.

RTFM.

The ELDK documentation (see file README.html) clearly states that you
have to run the two scripts ELDK_MAKEDEV and ELDK_FIXOWNER before you
can use the filesystem as NFS root.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If programming was easy, they wouldn't need something as  complicated
as a human being to do it, now would they?
                       - L. Wall & R. L. Schwartz, _Programming Perl_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
