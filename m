Message-ID: <381878FB.8916CB9@netx4.com>
Date: Thu, 28 Oct 1999 12:25:31 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Andreas Tobler <a.tobler@schweiz.ch>
CC: wung_y@263.net, linux-ce-devel <linuxce-devel@linuxce.org>,
        linux-ppc <linuxppc-dev@lists.linuxppc.org>,
        linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: help, build Cross GCC
References: <38184905.117429CD@263.net> <38184DC8.6773D84D@schweiz.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler wrote:


> Try here:
> http://members.home.com/mmporter/linux/cross/

I have binaries for RedHat 5.2 Linux/x86 on ppc.kernel.org in
the embedded directory.  It is a tar file called xppctools or
something like that.  These load into /opt, so they are easy
to remove if you want to do something else.  Just put the bin
directory in your search path.

I believe this was the last EGCS version before the GCC merge.
You will need to select your favorite libraries and include
files, as those are not included.  It will build the kernel
just fine.

It is something to get you started....


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
