Message-ID: <3A8C5DB5.2CE9D3C@mvista.com>
Date: Thu, 15 Feb 2001 17:52:37 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: frowand@mvista.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: program exception emulates mfspr PVR
References: <20010215160658.P26702@altus.drgw.net> <3A8C5A95.9A94F914@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Frank Rowand wrote:

> And why add this extra cruft?

Perhaps you should ask the people that requested it, probably one
or two doors down from your office..........

It was added so programs (actually libraries) executing prior to
any of the /proc stuff set up (like init) could detect the processor
type and install (or avoid) a variety of instructions unique to
that processor.  Cache line information, availability of floating point,
Altivec, unique silicon errata workarounds, etc. could be incorporated
into the library, reducing the requirement to have uniquely compiled
libraries for all of the processor variants.  This has been discussed
for ages on a variety of mailing lists, and emulating the 'mfspr PVR',
which is hardly cruft compared to some of the other stuff that exists,
was the easiest and least intrusive method.



	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
