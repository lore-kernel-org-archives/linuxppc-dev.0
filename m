Return-Path: <sascha.schroeder@aethyx.com>
From: Sascha Schroeder <sascha.schroeder@aethyx.com>
Subject: Getting kernel 4.14 to run on PS3
To: geoff@infradead.org
Cc: Linuxppc-dev@lists.ozlabs.org
Message-ID: <9621b73a-12e0-1254-932c-2456238b5526@aethyx.com>
Date: Fri, 8 Dec 2017 10:24:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Geoff,

I'm still thankful today that you're running a PS3 Linux tree via
https://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git!
Good work!

I yesterday tried to compile the newest kernel 4.14 for my PS3 running
OtherOS++ and "Red Ribbon GNU Linux" from 2014. I even succeeded and
created the three *.deb files and installed them afterwards.

Unfortunately, my machine did not boot.

As far as I read in very old sources, this could be that my machine is
using OtherOS++ on firmware 3.55.2 and not the Sony OtherOS prior
firmware 3.2x.

I'm in contact with the creator from "Red Ribbon" and he mentioned we
have to manually patch PS3 linux kernel.

So, my question 1 would be: which patches would I need to get the newest
kernel 4.14 running on my PS3 machine?

Question 2 would be: maybe there exists a second tree where we can get
the kernel for OtherOS++ too?

Maybe there is other stuff I am missing, but as far as I can tell the
sources compile beautifully on the PS3 powerpc machine. Only downside:
it takes 4-5 hours depending on what you selected in the step of "make
menuconfig"...

Thanks so much in advance and have a good time,

Sascha
