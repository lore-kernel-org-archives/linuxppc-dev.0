To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PQ2FADS Support 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Oct 2003 10:23:48 EDT."
             <3F8FFB74.2030609@catapult.com>
Date: Sat, 18 Oct 2003 23:03:23 +0200
Message-Id: <20031018210328.C21DFC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F8FFB74.2030609@catapult.com> you wrote:
>
> I would like to use the eldk, but, when I pulled down the
> latest CVS version this morning and try to configure there
> is not an option for PQ2FADS.

I think this is a misunderstanding. The ELDK is a  _toolkit_,  not  a
kernel  distribution.  (Yes,  the  ELDK  does  contain a Linux kernel
source tree, too - the current version of the ELDK contains our 2.4.4
kernel tree).

But if you're looking at specific board support, you  can  use  _any_
kernel source tree in combination with the ELDK tools.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
1 1 was a race-horse, 2 2 was 1 2. When 1 1 1 1 race, 2 2 1 1 2.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
