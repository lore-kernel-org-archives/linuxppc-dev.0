Message-ID: <3C18CC34.5CF24CDA@seranoa.com>
Date: Thu, 13 Dec 2001 10:41:40 -0500
From: Andrew Dixon <andrew.dixon@seranoa.com>
MIME-Version: 1.0
To: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root=/dev/nfs on sbc8260
References: <3C17E07F.7144B7BF@seranoa.com> <3C18445A.80505@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is something very strange.  In PPCBoot I set the ethernet address
to 00:a0:1e:90:15:55.

=> printenv
<snip>
ethaddr=00:a0:1e:90:15:55
<snip>

And PPCBoot uses bootp to get lots of good information about who the
board is.

Now, as I watch Linux try to come up I see the following:

eth0: FCC ENET Version 0.2, 00:a0:1e:d0:15:55
fec: Phy @ 0x1, type 0x000fd04b

Notice that the ethernet address has changed.  Very odd.  I assume that
this info should be passed from PPCBoot to Linux via the board info data
structure bd_t.

Has anyone else seen this before?

Thanks,
Andy

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
