From: kd@flaga.is
Subject: Re: Building Glibc
To: "René Pachernegg" <rene.pachernegg@apus.co.at>
Cc: greyham@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF53CD3670.3BBFE50D-ON00256865.0060BF32@flaga.is>
Date: Thu, 13 Jan 2000 17:39:36 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I think (if I remember correctly) that I fixed this error by adding my
cross-bin path to the $PATH variable, e.g. export
PATH=/usr/ppccross/bin:$PATH

K.D.


Building gcc stopped with:
as: unknown option -ppc

Any propositions?
Regards
     Rene


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
