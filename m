From: Aain_Devarenne%ZODIAC@zodiac.com
Subject: Using MVL with multicast
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFAC0A3504.25D3C40C-ONC1256DEA.0050B12A@zodiac-intranet>
Date: Wed, 26 Nov 2003 15:42:29 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello there,

my question is related to multicast.
An application working under RedHat 8.0 on a PC can send UDP packets to a
multicast group.
The same application compiled to PPC target (IBM Walnut derived custom
board) running under MVL control cannot do the same job:
- sockets are created and packets send with sendto(). At that time I get a
"Unreachable network" message
- changing the multicast group address to a more common unicast address
allows sendto() working fine
- trying to ping the multicast group address produces a "connect" error
message

I saw some fields to enable multicast capabilities in Kernel configuration
but I'm not sure about my choices. May be some packages are requested too.

Thanks for your help to deal with that goal : what is mandatory requested
to get this application working on our target the way it works under RH ?


MARTZ Gérard / DEVARENNE Alain
IN-SNEC/Bord
5 Avenue des Andes
91943 Les Ulis
0169827912


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
