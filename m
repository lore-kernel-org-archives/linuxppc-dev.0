Message-Id: <v04003a06bae9957ba064@[192.168.1.4]>
In-Reply-To: <20030515190158.GD11565@ip68-0-152-218.tc.ph.cox.net>
References: <20030515074214.GA787@plato.local.lan>
 <20030515074214.GA787@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 15 May 2003 14:11:42 -0500
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
Subject: Re: [PATCH] educate users about x86 specific kludges instead of
 hiding thier ignorance
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 2:01 PM -0500 5/15/03, Tom Rini wrote:
>(and, btw, 'bzImage' on m68k is,
>or was anyhow, a bzip2 image adding to the fun)

Yeah, that would be my fault. :)

I wrote that in before I had access to an x86 linux machine, so I was not
aware that "bzImage" meant "work around stupid bios/realmode limitations"
and not "use bz2 compression".

Speaking of which, is it even possible these days to build a kernel small
enough for (non-b) zImage on x86? I think it's been a while since I've even
made one that can fit on a floppy.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
