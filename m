Date: Sat, 15 Apr 2000 00:47:12 +0200
From: claus <enneper@olis.north.de>
To: linuxppc-dev@lists.linuxppc.org
Cc: mol-general <mol-general@lists.maconlinux.org>
Subject: pcmcia - 2.5"ide 
Message-ID: <20000415004712.L603@hotmail.com>
Reply-To: cl.en@gmx.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi.
some playing in /etc/pcmcia/config.opts :
include memory 0x90000000-0x90ffffff
include port 0x1000-0x10ff
(THX to A.Tobler)

was giving me access to my PCMCIA_2.5"_IDE_HD_enclosure :)
adding the hde partitions to molrc results in success.
now its possible for me to move any 'hfs' to the external HD;

Could those of you using a PB check this setting with your PCMCIA-Cards for any incompatibilities?
I mean, I really spend some time with this problem and I don't think it was necessary, because some of you did know that probably.
Adding those hints to 'config.opts' in the next release of a PPC distribution would be quite nice.

Greetings
Claus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
