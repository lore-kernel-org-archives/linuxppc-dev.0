To: Brian Waite <waite@skycomputers.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Steven Scholz <steven.scholz@imc-berlin.de>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: BOOT_TARGET pImage & uImage ??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 18 Sep 2003 14:22:28 EDT."
             <200309181422.32546.waite@skycomputers.com>
Date: Thu, 18 Sep 2003 20:40:50 +0200
Message-Id: <20030918184055.6AB94C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200309181422.32546.waite@skycomputers.com> you wrote:
>
> I think uImage is enough. Wolfgang strongly discourages any use of PPCBoot
> these days and it just seems silly.

uImage should do.

Ummm... actually I only discourage the use of PPCBoot for development
of _new_ projects. Just using it on  existing  systems  is  perfectly
fine (I have some around and see no reason to update).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Never ascribe to malice that which can  adequately  be  explained  by
stupidity.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
