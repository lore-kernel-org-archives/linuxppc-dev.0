Message-ID: <367CC5DE.D6035DDF@wanadoo.fr>
Date: Sun, 20 Dec 1998 10:39:42 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Keith Jacob <kjacob@wantree.com.au>
CC: linux-pmac list <linux-pmac@samba.anu.edu.au>,
        linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user list <linuxppc-user@lists.linuxppc.org>
Subject: Re: undefined symbol: _IO_2_1_stdin_
References: <199812200348.LAA24006@mule.wantree.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Keith Jacob wrote:
> 
> Any clues? Please?
> 
> Full errror is
> 
> error in loading shared libraries
> : undefined symbol: _IO_2_1_stdin_
> 
> When?
> 
> Whenever I try to run pre-compiled binaries (mostly from stock LinuxPPC
> RPMs) from late-1998 builds.

Are you trying to run R4.1 binaries with R4 libraries? This won't work.
You have to upgrade your glibc (and everything else). Better wait for R5
and stay with binaries linked with glibc-961212 (if you can find out
which ones they are :-)).

I am pretty sure this(*) will be one of the very FAQs over the next
months. That's why I kept the excessive crossposting list from Keith's
original. I would love to be wrong on this. 

> 
> BTW, Gary Thomas's latest egcs-1.1-1b RPMs include bins that exhibit this
> behaviour, e.g. gcc!

This is very strange. So maybe your problem is something else, after
all.

(*) A typical variant for pre-R5 binaries is:
 error in loading shared libraries
: undefined symbol: __libc_start_main

--
Martin

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
