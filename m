To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Heretical Question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 09 Jul 2003 15:57:23 EDT."
             <20030709155723.G20807@borg.org>
Date: Wed, 09 Jul 2003 22:14:50 +0200
Message-Id: <20030709201455.C2393C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030709155723.G20807@borg.org> you wrote:
>
> I know it is wrong for me to ask, but is there (possibly already
> lurking in my Red Hat box?) a graphical front end to GDB that will
> work with embedded programming?  Emacs already lets me debug with

There is: "ddd".

Use it for example like this:

	bash$ export CROSS_COMPILE=ppc_82xx-
	bash$ ddd --debugger ${CROSS_COMPILE}gdb &

> It is possible ddd would do, but it also seems to be for native
> debugging only too.

No, with  the  "--debugger"  option  you  can  tell  it  to  use  the
cross-GDB, too.

> Suggestions?

RTFM :-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Clothes make the man. Naked people have little  or  no  influence  on
society.                                                 - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
