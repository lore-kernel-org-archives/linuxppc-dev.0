MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: tlbwe, rfci instructions and gcc cross assembler
Date: Fri, 12 Apr 2002 10:10:39 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CFB2@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> You did -Wa,m405, not -Wa,-m405.  What tree is this from anyhow, this
> has been fixed in linuxppc_2_4_devel for awhile now.

Doh!  At least daily, I prove myself to be an idiot.
Of course it works if I put the dash in there.

I'm using linuxppc_2_4.  I thought that'd be more
stable than linuxppc_2_4_devel.  Maybe that wasn't
such a good choice.

I'll give linuxppc_2_4_devel a try, since I'm not sure
how to fix the Makefiles anyway.  (I think
ASFLAGS = -Wa,-m405, but I'm don't know how to tie it in
with Config.in.)

Thanks,
-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
