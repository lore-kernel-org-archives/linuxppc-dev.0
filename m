Date: Thu, 02 Oct 2003 09:18:20 +0200
From: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Subject: RE: Where to Put Ethernet MAC Addresses?
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <F886A68DA978614991E47D82EA26B54210E956@csy-exchange1.giat.intra>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> -----Message d'origine-----
> De : owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]De la part
> de Howard,
> Marc
> Envoyé : mercredi 1 octobre 2003 22:44
> À : 'Dan Malek'; Kent Borg
> Cc : linuxppc-embedded@lists.linuxppc.org
> Objet : RE: Where to Put Ethernet MAC Addresses?
>
>
>
> I personally favor the "roll your own MAC address from the
> serial number" approach but it does have the drawback that
> you must have unique serial #'s on the boards.  If the serial
> numbers are entered (or not entered) by lazy humans you could
> potentially have two devices with the same MAC address on a
> network.  I also select as the first 3 bytes of the MAC
> address the address assigned to a defunct company and the lower
> 3 bytes derived from the serial number.

There is a range of MAC adresses for local use (inside an appliance
or even inside a vehicle would be the case). That's what I use for
in-lab development on custom MPC855T boards.

See for instance <http://www.centsoft.com/mac.htm>.

If you don't mass-produce, using the current time for a seed might
work. :)

HTH
--
Albert.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
