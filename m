Message-ID: <3AA5113F.A0B78521@ncal.verio.com>
Date: Tue, 06 Mar 2001 08:33:03 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Pismo Aty128fb problem in 2.4.3-pre*?
References: <3AA41B77.73470672@ncal.verio.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Narrowed down the problem a bit more. Specifying
"video=aty128fb:mode:17" works; also without the mode.
But, adding a depth parm (8,16,24, or 32) causes the
fb init failure. It defaults to 8 and fbset works for
8,15,16,32 but 24 causes a blurry image.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
