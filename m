To: "Ken Chou" <kchou@istor.com>
Cc: "Brian Kuschak" <bkuschak@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: debugging kernel modules 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 05 Aug 2002 18:12:39 PDT."
             <7D036BD3216A084DB1BD9D62BCEAF2900884D8@mail1irv.inside.istor.com>
Date: Tue, 06 Aug 2002 08:53:55 +0200
Message-Id: <20020806065400.7C0C71087B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <7D036BD3216A084DB1BD9D62BCEAF2900884D8@mail1irv.inside.istor.com> you wrote:
>
> Is there is pointer on how to debug Linux Kernel and Statically Linked
> Device Drivers?

This is implicitely included here:

> Wolfgang has a nice tutorial on this:
> http://www.denx.de/doc/TQM8xxL/debugging.html

Just follow the description how to start the Linux kernel  under  the
debugger  -  all  the  statically  linked drivers etc. are accessable
without additional tricks.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"...this does not mean that some of us should not want, in  a  rather
dispassionate sort of way, to put a bullet through csh's head."
                   - Larry Wall in <1992Aug6.221512.5963@netlabs.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
