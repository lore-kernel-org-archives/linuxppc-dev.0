To: "Tord Andersson" <tordson@algonet.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200 LOWBOOT problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 02 Feb 2004 21:20:52 +0100."
             <07b501c3e9ca$0f1c89e0$f62d7f3e@emil>
Date: Tue, 03 Feb 2004 02:36:19 +0100
Message-Id: <20040203013624.66B93C108E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Tord,

in message <07b501c3e9ca$0f1c89e0$f62d7f3e@emil> you wrote:
>
> >DDR: OK (use icecube_5200_DDR configuration in U-Boot); the LOWBOOT
> >     option is not working yet (we are working on this)
>
> I have serached the PPC and U-Boot lists but have not been able to find more info.

I guess there are not many DDR based MPC5200 boards out  there;  most
people seem to be using the LITE5200, or follow this design closely.

> What effect does the LOWBOOT problem have? Page allocation error during kernel startup or something else?

U-Boot does not boot, i. e. nothing goes.

> Any additional information would be very helpful.

Actually nothing happened yet. We had  some  other,  higher  priority
issues  to solve. I'll check in the fix to the U-Boot tree as soon as
it becomes available.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Hindsight is an exact science.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
