To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: boot methods 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 03 Nov 2001 08:15:53 MST."
             <20011103081553.C29932@cpe-24-221-152-185.az.sprintbbd.net>
Date: Sat, 03 Nov 2001 19:36:21 +0100
Message-Id: <20011103183626.E9E2D10CDB@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <20011103081553.C29932@cpe-24-221-152-185.az.sprintbbd.net> you wrote:
>
> changes.  And I don't think the PPCBoot wrapper needs to be all that big
> either.  I do need to sit down and verify this, but a PPCBoot wrapper
> could be as minimal as taking a current bd_t structure and converting it
> to bi_recs.  No duplicated serial, et al.

I think we'll implement it the other way round: as soon  a  there  is
any  definition  of  the  intended interface we will make PPCBoot use
bi_recs directly, and provide an (optional) bd_t interface for compa-
tibility with old systems.

[We already have to support two interfaces right now: one with clocks
in MHz, the other in Hz. It's not exactly nice, but it works.]

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There is nothing in this world constant but inconstancy.      - Swift

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
