To: Dan Kegel <dank@kegel.com>
Cc: Brian Padalino <bpadalino@perigee.com>, zjzhou@newrocktech.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: how to use busybox to make a ramdisk? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 29 Aug 2003 07:50:01 PDT."
             <3F4F6819.1090002@kegel.com>
Date: Fri, 29 Aug 2003 16:52:43 +0200
Message-Id: <20030829145248.C000EC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F4F6819.1090002@kegel.com> you wrote:
>
> Stock genext2fs doesn't handle ramdisks bigger than 8MB, but
> there are patches that fix this, and I've been using them happily
> for about nine months.  (Maybe they're in the mainline now; not sure.)

A patched & extended version  (based  on  Erik  Andersen's  work)  is
included with the ELDK.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
365 Days of drinking Lo-Cal beer.                       = 1 Lite-year

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
