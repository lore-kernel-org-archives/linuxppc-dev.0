Mime-Version: 1.0
Message-Id: <p05111b12b9d35ea3c854@[63.220.231.176]>
In-Reply-To: 
 <Pine.BSF.4.44.0210161110480.97189-100000@shell.unixbox.com>
References: 
 <Pine.BSF.4.44.0210161110480.97189-100000@shell.unixbox.com>
Date: Wed, 16 Oct 2002 14:27:22 -0400
To: <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: part deux Re: Radeon 7000 in 9500 - which slot?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>It is not detecting the heads properly because on many "mac" radeons, the
>firmware doesn't initialize the SCRATCH registers properly which contain
>information about display type.  There is no reliable method of probing
>display type on ppc so I will end up adding a display type option to
>radeonfb next version.

Sounds like until you have a chance to do this, I'm outta luck on
accelerated video. Keep me in mind for beta testing, please :-) Can I
assume I will be able to use the card with offb as usual? What about
dual monitors with xinerama - should that still work, albeit
unaccelerated?

Odd... surely there's no way I'm the only one with Mac and a 7000,
eh? Wonder why I never ran across this issue in searching the
archives... the only citation I found was the issue about it being in
the top slot, but I had the impression that the correspondent had it
working... will go look that up again.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
