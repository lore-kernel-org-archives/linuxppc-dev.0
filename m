Message-Id: <9902272143.AA30166@marc.watson.ibm.com>
To: "Kevin B. Hendricks" <kbhend@business.wm.edu>
Cc: linuxppc-dev@lists.linuxppc.org, egcs@egcs.cygnus.com
Subject: Re: PowerPC and egcs gurus: Help! egcs PPC Float Min != JCK Float Min 
In-Reply-To: Message from "Kevin B. Hendricks" <kbhend@business.wm.edu>
   of "Sat, 27 Feb 1999 10:09:39 EST." <v03010d00b2fdb9273872@[209.96.179.170]>
Date: Sat, 27 Feb 1999 16:43:50 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	There seems to be some confusion between FLT_MIN and MINFLOAT.

FLT_MIN is the smallest NORMALIZED float = 1.1754943508222875e-38F
MINFLOAT is the smallest float (_EXPBASE ** (FMINEXP - 1)) = 1.40129846432481707e-45

	I do not know how the JCK actually is testing this, but the
PowerPC IEEE single-precision floating point can represent both values and
the real minimum depends on what one actually means.  float.h FLT_MIN does
not have the same meaning as Java Float_Min.

David

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
