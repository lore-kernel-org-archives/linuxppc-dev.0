Message-ID: <38FDF0C9.85A579AD@erols.com>
Date: Wed, 19 Apr 2000 13:45:45 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Chas Williams <chas@cmf.nrl.navy.mil>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128 and offb and linux-2.3.99pre6
References: <200004191429.KAA11052@borg.cmf.nrl.navy.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Chas Williams wrote:

> i think i have spotted an oversite, offb.c, the aty128 probing should
> come after the offb probing otherwise, my aty128 comes up as an
> unsupported framebuffer.  the following patch 'correctly' recoginizes
> my aty128 now:

<snip:patch>

Does this fix the problem w/ the broken 2.3.99 aty128pro driver?

--Nelson Abramson


--
"Apparently if you play the Windows NT CD backwards you hear satanic messages"
"You think that's bad, if you play it forwards it installs Windows NT!"
--orlando


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
