To: Bret Indrelee <Bret.Indrelee@qlogic.com>
Cc: Ibon Gotxi Garcia <igotxi@jazzfree.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Jean-Denis Boyer <jdboyer@mediatrix.com>,
	Dan Malek <dan@embeddededge.com>,
	Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question about modules 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Mar 2003 08:26:55 CST."
             <Pine.LNX.4.33.0303040826250.2281-100000@localhost.localdomain>
Date: Tue, 04 Mar 2003 15:25:53 +0100
Message-Id: <20030304142558.70689C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.33.0303040826250.2281-100000@localhost.localdomain> you wrote:
>
> Modules are generally easier to debug.

I'm not sure if I want to agree here.

First, you have to learn how to use GDB to deal with the symbol table
of a dynamically loaded module. Second, did you ever  try  to  set  a
breakpoint in the init function of a dynamically loaded module? It is
possible  to  do that, but you need a certain level of understanding,
and if your boot loader supports download over ethernet it is usually
easier and faster to debug this situation with  a  statically  linked
driver.


You are right however as far  as  the  modify-compile-load-run-unload
development cycle is concerned.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If I can have honesty, it's easier to overlook mistakes.
	-- Kirk, "Space Seed", stardate 3141.9

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
