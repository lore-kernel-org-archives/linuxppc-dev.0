Message-ID: <20010920143200.79354.qmail@web11002.mail.yahoo.com>
Date: Thu, 20 Sep 2001 07:32:00 -0700 (PDT)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: [Question] I want to use CSCOPE to port Linux kernel.
To: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200109201107.UAA15781@ldap.dacom.co.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have already libncurses.so.5.2
>
> So I tried as below, but I had the same result.
> ---------------------------------------------------
> # ln -s libncurses.so.5.2 libncurses.so.4
> # rpm -ivh cscope-15.3-1.i386.rpm
> error: failed dependencies:
>         libncurses.so.4 is needed by cscope-15.3-1

	Hi there.  RPM's dependancies are based on its database, and not on the actual
filesystem.  So the 'ln' wouldn't make any difference in this case.  Try this:

# rpm -ivh --nodeps cscope-15.3-1.i386.rpm

	That bypasses RPM's opinion of what is and should be installed, so you might
always have to remember that as a one-off.

=====
Medium System Administrator and Junior I.T. Manager of 5 yrs
 -- Now available -- Linux, MacOS, Unix-like systems
    -- http://mmmgood.net -- dan_bethe@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
