To: "Laurent Mohin" <laurent.mohin@acterna.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	u-boot-users@lists.sourceforge.net
Subject: Re: [U-Boot-Users] hang up after start_here 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 18 Aug 2003 09:54:51 +0200."
             <OFE8EA1A87.9A7B8A06-ONC1256D86.0028950A-C1256D86.002D5CE3@se.wavetek.com>
Date: Mon, 18 Aug 2003 10:39:27 +0200
Message-Id: <20030818083932.C7D24C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OFE8EA1A87.9A7B8A06-ONC1256D86.0028950A-C1256D86.002D5CE3@se.wavetek.com> you wrote:
>
> I've debugged and found that the board hangs in start_here function and
> doesn't reach the early_init function.
>
> Because the problem appears on only one of my boards out of 16, I suspect
> a hardware problem, and because it occurs just after mmu initialisation
> and caches enabling, I suspect more especially sdram accesses.
>
> I want to know if anybody has encountered a similar problem and if the
> diagnostic was the same.

This is a standard problem, which can show up in many forms.  My  bet
is  that  your  SDRAM initialization sequence is incomplete / broken.
Remember that it is NOT sufficient to set up the  mmeory  controller,
you must also intialize the SDRAM chips themself.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"What is wanted is not the will to believe, but the will to find out,
which is the exact opposite." - Bertrand Russell, _Sceptical_Essays_,
1928

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
