Message-Id: <200012080807.eB887Mm02137@denx.local.net>
To: Subodh Nijsure <SNijsure@SkyStream.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Psos bootrom booting Linux-ppc is that possible, done? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 07 Dec 2000 17:25:36 PST."
             <B25E2E5A003CD311B61E00902778AF2A0148B603@server1.skystream.com>
Date: Fri, 08 Dec 2000 09:07:22 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <B25E2E5A003CD311B61E00902778AF2A0148B603@server1.skystream.com>
Subodh Nijsure wrote:
>
> I got a MPC860 FADS board for which I just now got a PSOS based
> bootrom.
>
> Has anybody been successful in booting Linux from a pSOS bootrom?

Never tried, never will.

The FADS860 is one of the boards wich are supported  by  PPCBoot.  If
you're  looking for a powerful and convenient way to run Linux on you
board you should give it a try.

The PPCBoot project page is at http://ppcboot.sourceforge.net/  where
you  can  also find the CVS server with the latest source versions, a
user's mailing list is at <ppcboot-users@lists.sourceforge.net> , and
if you're looking for tarballs you can find them in
ftp://ftp.denx.de/pub/ppcboot/

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Am I your nanny? The kernel is there to support  user  programs,  but
it's a _resource_ handler, not a baby feeder.     - Linus Torvalds in
      <Pine.LNX.3.91.960425074845.22041C-100000@linux.cs.Helsinki.FI>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
