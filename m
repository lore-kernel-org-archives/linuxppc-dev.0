To: macdonldc@netscape.net (Craig MacDonald)
Cc: linuxppc-embedded@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: PPCBoot and IMMR remapping for linux 2.4 on sbc8260 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Sep 2001 17:29:19 EDT."
             <4E48AD2F.671BD424.031B03A1@netscape.net>
Date: Sun, 23 Sep 2001 20:00:12 +0200
Message-Id: <20010923180017.8F0751009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Craig,

in message <4E48AD2F.671BD424.031B03A1@netscape.net> you wrote:
>
> The immr_base value in PPCBoot on my sbc8260 is
> 0x0f000000. I have been reading here that the
> best value for linux is 0xf0000000.

THis is your own bug, then. The default configuration of PPCBoot  for
the SBC8260 uses this definition in "include/config_sbc8260.h":

        #define CFG_IMMR 0xf0000000

> I don't have easy access to flash my PPCBoot
> to a new immr_base value, but I want to run

Where exactly is the problem? It is a trivial job to use any  running
version   of  PPCBoot  to  upgrade  to  a  new  version  (just  using
"tftp", "protect off", "erase" and "cp.b" commands).


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
While most peoples' opinions change, the conviction of their correct-
ness never does.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
