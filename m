Message-ID: <38FD06B2.EC638512@erols.com>
Date: Tue, 18 Apr 2000 21:06:58 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: "Francis G. McCabe" <fgm@fla.fujitsu.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Putting linuxPPC on my new pismo
References: <38FD00AA.6C423CB@fla.fujitsu.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Francis G. McCabe" wrote:

> I realize that there has been a lot of discussion about this. However, I
> havent seen my problem mentioned.
>
> When I try to install linuxPPC 2000 on my brand new PB2000, I get the
> error:
>
> hda: lost interrupt

If you searched the archives for your error message, you would find the
answer you seek (it is not a powerbook only problem).

Make sure you are using yaboot to boot the powerbook, not bootX.  Using
bootX on the newworld machines causes that problem to occur.

HTH
--Nelson Abramson

--
"Apparently if you play the Windows NT CD backwards you hear satanic messages"
"You think that's bad, if you play it forwards it installs Windows NT!"
--orlando


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
