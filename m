To: Kate Alhola <kate@iti.fi>
Cc: Stefan Nickl <Stefan.Nickl@kontron.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Jul 2004 10:55:10 +0300."
             <40E514DE.6020300@iti.fi>
Date: Fri, 02 Jul 2004 10:51:39 +0200
Message-Id: <20040702085145.0A0C9C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40E514DE.6020300@iti.fi> you wrote:
>
> >This is why we implemented an accelerated X11 driver for the Coral-P.
> >
> I should try this new one. With the older one i have some problems with get all required
> virtual console etc drivers to compiled to kernel to make Xfree 4.4 happy. Ok, now
> there looks a like to be icecube_5200_CoralP_defconfig

Yes, this is what we use for testing. It requires  a  USB  mouse  and
keyboard to make the X11 server happy.

> May be it is worth to try use QT with X11 server instead using embedded qt direct to
> fb device. In older driver it was anyhow much better to use embedded qt direrctly.

We have standard versions of Debian  and  YellowDog  running  on  the
LITE5200, so Qt embedded should be pretty straightforward, too.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Make it right before you make it faster.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
