Message-ID: <F14441D40E5AD3118886005004607AD10BDD50@mail.libra.de>
From: "Halfmann, Klaus" <khalfmann@libra.de>
To: "'Sacha Varma'" <sacha@ssl.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: AW: PCI compatibility
Date: Thu, 20 Jul 2000 09:52:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sacha Varma [mailto:sacha@ssl.co.uk] wrote:
> I came across http://til.info.apple.com/techinfo.nsf/artnum/n16365 , a
1994 note
> which discusses compatibility of PCI cards in general with
Macs/OpenFirmware.

> It's quite terse but states that PCI cards that need to be active on boot
> (video cards) will generally not work, and cards that don't generally
will.

OF needs some minimum hardware to operate, this can be some serial ports
or a keyboard and a framebuffer device. So an OF complient videocard should
include a minimum of OF code to set up such a device. Newer version
(new world rom) need acces to a storeage device, too. Older ones acces the
Apple ROMs.

> . can anyone point me to more detailed resources?
This area of technotes is quite ok, your might look for
"Designing PCI cards and Drivers for Power Macintosh computers"
> . what's the state of play 6 years on? is there a trend towards OF
compliance?
Dont know in general but there are a lot of videocrads for mac out there ...
> . what does "active on boot" really mean?
See exaplanation above
> . why can't a card be activated after boot, programmatically?
This is no problem. Any OS can load/apply a driver _later_ to acces
that card, but OF will know nothing about it (except some basic PCI
information)
> . does anyone maintain a list of compatible PCI cards (of all types)?
For Linux ? For Mac OS ? ...

Greetings,

|       |                  Klaus Halfmann       khalfmann@libra.de
|       |
|    i  | --.  r---  -- |  Libra Software GmbH  Tel +49 (0)621 41997-0
|    |  b-- |  |    a-- |  Erzbergerstr. 17     Fax +49 (0)621 41997-30
L--- |  --- |  |    .---.  68165 Mannheim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
