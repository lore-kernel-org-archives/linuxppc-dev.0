To: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Porting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 23 Apr 2003 17:22:43 +0200."
             <sea6cbef.014@mail.frequentis.com>
Date: Wed, 23 Apr 2003 19:18:46 +0200
Message-Id: <20030423171851.E0EACC5E29@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <sea6cbef.014@mail.frequentis.com> you wrote:
>
> So the question is again: do you support every pcmcia card (not only ide) =
> within the kernel?

I cannot claim to support _every_ PCMCIA card.

We have tested the code with flash disk cards, CompactFlash adapters,
ATA harddisk adapters, network cards, WLAN cards, and modem cards.

I am pretty confident that any PCMCIA card that runs on a  MAC  under
Linux will run with our CS package as well.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
What can it profit a man to gain the whole world and to come  to  his
property with a gastric ulcer, a blown prostate, and bifocals?
                                     -- John Steinbeck, _Cannery Row_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
