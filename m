To: Jeff Stevens <jsteve17@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK based on YDL 3.0? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Nov 2003 10:32:24 PST."
             <20031112183224.7655.qmail@web41401.mail.yahoo.com>
Date: Wed, 12 Nov 2003 20:41:28 +0100
Message-Id: <20031112194133.8AED5C5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jeff,

in message <20031112183224.7655.qmail@web41401.mail.yahoo.com> you wrote:
>
> I am getting ready to build a filesystem based on the
> YellowDog Linux 3.0 release.  However, when I
> downloaded the build environment from www.denx.de, I
> notice that the ELDK_BUILD script already points to
> the 3.0 SRPMS.  Does that mean that there will be an
> ELDK release based on YDL 3.0 soon?  If so, what

This is correct. We are working on it. It should have been  ready  at
least  3  weeks  ago, but we're still fixing problems. If you want to
use the stable version 2.1.1 instead you  can  find  in  on  the  CVS
server tagged as ELDK_2_1_1

> kernel version will it use?

2.4.20 probably. Maybe something later - since we are so late  anyway
we  might  as  well  wait and use a kernel that supports the MPC5200,
too.

Why are you asking? Do you need some special version?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All he had was nothing, but that was something, and now it  had  been
taken away.                             - Terry Pratchett, _Sourcery_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
