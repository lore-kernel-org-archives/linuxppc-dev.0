Date: Fri, 19 Jan 2001 00:04:46 +0000
Subject: Re: [PATCH] 2.4.1p4 : dmasound ed21- Pismo byte-swap
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010119000317.336152EFC5@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I forgot to say...

this should (now I fixed a typo in the machine name) also solve the LE
byte-swapping problem on Pismo (by soft-swapping).

It is still not obvious why the Pismo does not swap in H/ware (it has the
smae AWACS chip id as the Lombard).

if you downloaded the modules or the diff before 00:00 GMT 19/01/2001 you
need to fetch it again.

cioa,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
