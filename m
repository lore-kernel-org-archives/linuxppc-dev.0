From: jonb@marel.is
Subject: Re: Porting to custom MPC823e board
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF3D4CE5BC.2ACEB995-ON0025695A.0038687F@marel.is>
Date: Thu, 14 Sep 2000 10:19:38 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I found out what the problem was.  The configuration of port A had one bit
in
the wrong place.  Ethernet now works on the board.

Thanks to all,


Jon Benediktsson
Marel hf.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
