Message-Id: <200003072157.QAA95728@borg.cmf.nrl.navy.mil>
To: Tom Rini <trini@kernel.crashing.org>
cc: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: nvram access in 2.3.48?
In-reply-to: Your message of "Tue, 07 Mar 2000 14:48:23 MST."
             <20000307144823.E399@opus.bloom.county>
Date: Tue, 07 Mar 2000 16:57:33 -0500
From: Chas Williams <chas@cmf.nrl.navy.mil>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Another weiredity I've come across in my 2.3 crusade: /dev/nvram
> doesn't seem to work anymore.

this problem arises from a different source. the nvram driver in
drivers/macintosh needs to be converted to use the new driver initalization
scheme (like the driver in drivers/char/nvram.c)

there were some posts about this about a month or so ago.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
