Message-ID: <02c101c15df4$58bb2e30$d8020101@aztec.local>
From: "Frederic Soulier" <soulier@aztec-radiomedia.com>
To: "Steven Scholz" <steven.scholz@imc-berlin.de>,
	"LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
References: <3BD912A4.A623F870@imc-berlin.de>
Subject: Re: USB and MPC855T/860T ???
Date: Fri, 26 Oct 2001 10:00:52 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Steven,

> I'd love to put some USB functionality to my custom MPC855T board.
>
> I noticed USB support for USB devices. But which USB controllers are
> actually supported? Which controller would be the best?

Linux provides now a good USB hosts/devices support. You can have a look at
the Linux USB Project page  : http://www.linux-usb.org/. You have to
consider that your microcontroller doesn't integrate a USB host (if you want
one, you may reconsider your choice and look a the MPC-850 family).

Some mails on this mailing-lists were published about USB host/device. Other
interesting informations should be found through nesgroups like
news://comp.arch.embedded

Feel free to ask me directly if you want more precise informations.

Regards,

Frederic.

---
     Frederic Soulier    -    Aztec Radiomedia  /  Digigram Europe
  31, rue du chemin de fer,  F-67087 Strasbourg Cedex 2, France
   Phone : +33 (0) 3 88 30 80 36  /  Fax : +33 (0) 3 88 30 90 99
                     Web site : http://www.digigram.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
