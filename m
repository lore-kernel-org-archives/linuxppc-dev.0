Message-ID: <002201bf6861$20f24d10$69f001dc@sjzhu.sps.mot.com>
From: "Shuangjun Zhu" <r44089@email.sps.mot.com>
To: "Dan Malek" <dan@netx4.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Help about MPC823 Video and Cache
Date: Thu, 27 Jan 2000 08:54:54 +0800
MIME-Version: 1.0
Content-Type: text/plain;	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, everyone

I'm using kernel version 2.2.13 on my MPC823 FADS board
to display on TV. I have a problem:

After the system boot up, the text on the TV flicker fiercely out,
if I disable the I-Cache throught the EST visionProbe tool,
TV will not flicker out again.
Of course, if I disable the cache when the system boot up,
TV display OK.
So there is some relation between the cache and the video, I guess.


Do you have any suggestion?
Thanks in advacned!

BRs,
Shuangjun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
