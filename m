To: Chris Zimman <chris@cryptoapps.com>
Cc: Oliver Amft <oam@gmx.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI DMA memory problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 24 Jun 2003 14:19:35 CDT."
             <20030624191935.GA9845@dingdong.cryptoapps.com>
Date: Tue, 24 Jun 2003 22:22:19 +0200
Message-Id: <20030624202224.C0755C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030624191935.GA9845@dingdong.cryptoapps.com> you wrote:
>
> I don't know that it'd necessarily be related, but for the 405GP,
> PPCBoot 1.2.0 doesn't have the PCI bridge setup quite right for all
> PCI devices (eg. 82559 won't work).  I have code to fix the bridge

PPCBoot-1.2.0 is more than 8 months  old.  I  recommend  updating  to
U-Boot (top of CVS).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
When properly administered, vacations do not  diminish  productivity:
for every week you're away and get nothing done, there's another when
your boss is away and you get twice as much done.  -- Daniel B. Luten

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
