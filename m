To: "Muhammad Sarwar" <msarwar@mangrovesystems.com>
Cc: "Steven Rothweiler" <Stevenr@raritan.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: AgileDB and Abatron BDI 2000 ICE 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 11 Jul 2003 10:58:03 EDT."
             <8529B5552D4EAA4DAEDF49650C64B2B436E4ED@TARPON.mangrovesystems.com>
Date: Fri, 11 Jul 2003 17:28:42 +0200
Message-Id: <20030711152847.E7C14C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <8529B5552D4EAA4DAEDF49650C64B2B436E4ED@TARPON.mangrovesystems.com> you wrote:
>
> You may be rite, Agile may not be for those who have been using GDB for
> some time...and know how to add "some custom-defined buttons" in
> DDD....;-)

Now this is _really_ simple. For example:

Start DDD. Click "Commands" => "Edit Buttons"
Enter:	"target remote bdi:2001 //  Connect to BDI"
Click "OK".
See a new button "Connect to BDI" appear. Click it.

Don't forget to "Save Options" if you want to make  your  definitions
permanent.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I will not say that women have no character;  rather, they have a new
one every day.                                               -- Heine

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
