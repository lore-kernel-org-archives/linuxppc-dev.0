Message-ID: <3F42104C.1080507@kegel.com>
Date: Tue, 19 Aug 2003 04:55:56 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: zjzhou@newrocktech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: problems on building linux kernel
References: <000101c36644$7f9c12d0$9f02a8c0@newrock2>
In-Reply-To: <000101c36644$7f9c12d0$9f02a8c0@newrock2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


John Zhou wrote:
> ppc-linux-gcc -D__KERNEL__ -I/opt/Embedix/home/abc/project/ppcTest/build/rpmdir/BUILD/linux-2.4.1/include ...
> Error: Internal assembler error for instruction bdnzlr- ...
> Error: Internal assembler error for instruction bfctrl+
> Internal error, aborting at ../../gas/config/tc-ppc.c line 1309 in md_begin

Looks like the error reported in
http://sources.redhat.com/ml/binutils/2002-02/msg00500.html
which was presumably fixed in binutils-2.12.
Where'd you get your compiler?
If you have a supported copy of Embedix, contact the vendor...
Otherwise, you might try upgrading to newer binutils on your own.
- Dan

--
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
