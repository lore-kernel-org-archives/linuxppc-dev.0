Message-ID: <396555DC.E31813E0@erols.com>
Date: Fri, 07 Jul 2000 00:00:29 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Multi-boot advice.
References: <200007070652.HAA20893@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> This is interesting.  I've seen (several times) the comment that the Apple
> Drive Setup tool doesn't work for Linux.
>
> However, it certainly did for me (on the Lombard & on a 9600/233)... under
> what circumstances does it fail?

Apple Drive Setup from MacOS 9 will cause problems if you are using a certain
version of BootX.  That problem was fixed by using a newer version of BootX or
moving to yaboot.

HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
