Message-ID: <40C1C67A.6010908@g-house.de>
Date: Sat, 05 Jun 2004 15:11:22 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix typo in binutils version check
References: <20040605074341.GA15279@suse.de> <40C1A334.5010402@g-house.de> <20040605111135.GA30640@suse.de>
In-Reply-To: <20040605111135.GA30640@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Olaf Hering wrote:
|>why is this check bogus then? i tried to compile a kernel with some
|>recent binutils which didn't pass the test - compilation failed.
|>H.J.Lu's binutils [1] are working quite well, the releases from redhat
|>[2] seem to produce these results you wrote about.
|
|
| The checkbin target fails with current binutils cvs, you need an
| additional option like -many

...or i just stick to the hjl branch and everything works fine :)

- --
BOFH excuse #399:

We are a 100% Microsoft Shop.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
