Message-ID: <3B6EDD68.55E51A8A@mvista.com>
Date: Mon, 06 Aug 2001 14:09:44 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Elan Feingold <elan@nxnetworks.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel hangs at my_console_write
References: <NDBBLJLFCLLGDHJPGKGCKEBPEDAA.elan@nxnetworks.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Elan Feingold wrote:

> .... In the version we were using, the numbers in
> embed_config() seemed to indicate that Hz were desired, but after grepping
> around, we saw that some parts of the kernel wanted Mhz.

If you take everything from the same kernel baseline, all of this will
match.  At one point late in the 2.3.xx development, the values
were changed from MHz to Hz.  People weren't patching/merging
correctly to get all of the right parts at the same time.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
