To: "Alexander J" <Alexander.J@lntinfotech.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	owner-linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux Kernel Porting  in PPC405GPr
MIME-Version: 1.0
Message-ID: <OFC44E707C.3710DD5D-ONC1256CFA.00272CC4-C1256CFA.00289FCD@se.wavetek.com>
From: "Laurent Mohin" <laurent.mohin@acterna.com>
Date: Mon, 31 Mar 2003 09:12:12 +0200
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alexander,

Does your customization of PPCBoot 1.1.5 take into account the larger size
of the data cache of the 405GPr versus the 405GP?

I used to have the same problem that you described and it was a problem of
data cache size.

Hope this helps,

Laurent

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
