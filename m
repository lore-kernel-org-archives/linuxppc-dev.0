Message-Id: <4.3.2.20000504122838.047c11f0@mail.munich.netsurf.de>
Date: Thu, 04 May 2000 12:33:16 +0200
To: john peter grimes <jpgrimes@rainbow.uchicago.edu>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: KDE 2.0 compilation problems
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.SGI.3.96.1000503191045.17758D-100000@rainbow.uchicago
 .edu>
References: <200004280042.RAA18722@pop3.ucdavis.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 02:24 04.05.00, john peter grimes wrote:

>I was wondering if anyone had tried to compile KDE 2 lately.  I'm trying
>with yesterdays source and I get the error below in
>kdelibs/khtml/css
>
>I've got an almost standard linuxppc 2000 install which uses gcc-2.95.2-1g
>
>I can't find a report of this error on the kde web pages and looking at it
>I'm almost curious if it could be a problem with gcc for ppc (this file
>takes forever to compile) or some other ppc specific issue.

This is a known bug, I'm currently working on a fix and I'll upload new
RPM's soon.

>Is anyone else compiling kde2, this is my first attempt.

Otherwise KDE2 compilation worked fine for me (I use the RawHide SRPMs).

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
