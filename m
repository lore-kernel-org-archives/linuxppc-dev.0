To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 Jun 2002 17:11:36 EDT."
             <3D10F388.5@embeddededge.com>
Date: Thu, 20 Jun 2002 00:15:27 +0200
Message-Id: <20020619221532.F3C7A10301@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

in message <3D10F388.5@embeddededge.com> you wrote:
>
> The 2.4 source base is no longer supposed to be a development base.
...
> kernel is what it is, like it or not.  If you want something new and different,
> it belongs in the 2.5 tree to show up at some point in the future.

So what is your suggestion if I want to provide a patch that supports
some new hardware?

Obviously I want to get it added to a stable tree, so we can  use  it
in  a real project. And often enough the hardware is instable enough,
so I don't need the additional thrill of an instable Linux kernel.


I understand that 2.4 should get stable, but  there  is  a  huge  gap
between  2.4  and 2.5, so neither fits - well, actually 2.4 fits _my_
requirements.

What do you recommend to do?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
All these theories, diverse as they are, have two things  in  common:
they explain the observed facts, and they are completeley and utterly
wrong.                       - Terry Pratchett, _The Light Fantastic_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
