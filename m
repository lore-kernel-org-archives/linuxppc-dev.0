Message-Id: <200301280810.JAA19807@hzsms01.nl.lucent.com>
Date: Tue, 28 Jan 2003 09:10:19 +0100 (MET)
From: Jaap-Jan Boor <jjboor@lucent.com>
Reply-To: Jaap-Jan Boor <jjboor@lucent.com>
Subject: Re: C++ Library recommendations ...
To: linuxppc-embedded@lists.linuxppc.org, jimdon@sympatico.ca
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jim,

I just use libstd++ coming with gnu g++, it's not too big (shared ~300k)
compared to glibc (shared ~1.2 M)

when linking statically, the linker normally only takes what you need,
so this will be less.

Jaap-Jan

>
> Hello,
>
> I have currently have some applications running with glibc/ulibc ...
>
> For porting purposes I would find it nice if there were some nice and
> small C++ libs supporting basic STL features (sets, vectors, lists) and
> things like iosstreams ...
>
> Anyone have any recommendations ...
>
> I believe last time I checked most C++ libs are rather large ??
>
> Any advice would be great ... thanks ...
>
> Jim
>
>
>

---
J.G.J. Boor
Lucent Technologies Nederland b.v.	Room:  BE-525
Optical Networking Group TMS Data 	Phone: +31 (0)35 687 4721
Larenseweg 50, P.O. Box 1168, 		Fax:   +31 (0)35 687 5976
1200 BD, Hilversum, The Netherlands	mailto:jjboor@lucent.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
