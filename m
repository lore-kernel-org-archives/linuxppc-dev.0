Message-ID: <39043C81.61D06CD2@erols.com>
Date: Mon, 24 Apr 2000 08:22:25 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
CC: LinuxPPC dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BootX and 9.0.4
References: <200004240622.XAA03501@pop3.ucdavis.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"W. Taylor Holliday" wrote:

> Are BootX and 9.0.4 incompatible? - BootX was working perfectly and then
> that stupid auto-update bumped me to 9.0.4 and all of a sudden I get that
> hd:lost interrupt message during linux boot. This problem does NOT occur
> when I boot into Mac from the os 9.0 CD and then run BootX.

Yes.  The ROM that comes with 9.0.4 cause incompatibilities with bootX.  The
archvies contain a wealth of information on ways around it.  The official
way is to use yaboot.

HTH
--Nelson Abramson

--
"Apparently if you play the Windows NT CD backwards you hear satanic messages"
"You think that's bad, if you play it forwards it installs Windows NT!"
--orlando


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
