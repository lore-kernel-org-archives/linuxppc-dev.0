To: "yhxing" <xyuhua_telecom@hotmail.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCMCIA problem help! 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Apr 2004 11:04:23 +0800."
             <Sea1-DAV123WOXs8Nxn0001ba6d@hotmail.com>
Date: Thu, 22 Apr 2004 08:21:53 +0200
Message-Id: <20040422062158.5AC3BC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Sea1-DAV123WOXs8Nxn0001ba6d@hotmail.com> you wrote:
>
>    Our board was bought from a company. This company use TQM823L board
> files in PPCBoot 1.1.5 as a model and it made some changes accroding to
> their hardware connections(but these changes are trivial). And the pc
> card voltage is 3.3V.

As I stated before:  I  guess  your  board  is  mis-configured.  Even
trivial changes of the hardware may need adaptions of the boot loader
and/or kernel sources.

You don't give enough information so  it's  impossible  to  say  what
might be wrong.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I used to think that the brain was the most wonderful  organ  in  my
body. Then I realized who was telling me this."        - Emo Phillips

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
