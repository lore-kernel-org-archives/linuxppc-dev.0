From: Ruedi.Hofer@ascom.ch
Date: Thu, 09 Dec 1999 14:55:42 +0100 (CET)
Subject: Re: Re: fadsrom -> mkrombin
To: kd@flaga.is
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <0FMH00L2E83LR2@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_NM0+22SqwEfI7yF2l/YpJw)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_NM0+22SqwEfI7yF2l/YpJw)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Thanx, applying the patch works!


But unfortunataly a file "byteconv.h" is missing:

rac26090:/usr/src/fadsrom # make mkrombin
cc -O0 -g -o mkrombin mkrombin.c
mkrombin.c:15: byteconv.h: No such file or directory
make: *** [mkrombin] Error 1
rac26090:/usr/src/fadsrom # 

It should probably be in your fadsrom directory!

Do you mind tgz-ing the whole fadsrom and sending it to me!?!?


Ruedi



--Boundary_(ID_NM0+22SqwEfI7yF2l/YpJw)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
