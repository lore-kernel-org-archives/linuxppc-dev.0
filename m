Date: Tue, 13 Jul 1999 11:25:05 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: A little trouble for MVME2400 boot from HD
In-Reply-To: <199907131750.CAA18581@mail.cc.tohoku.ac.jp>
Message-ID: <Pine.LNX.3.96.990713111941.19708B-200000@liberty.chnd1.az.home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Jul 1999, Kazunori Aoshima wrote:
> >Wow, that IPL Size is huge...no wonder BUG is upset.  The only time I've
> >seen this is when I've hacked up the PReP header info to make bootable
> >CD's.  
> 
> Is there some useful tools that makes ISOimages bootable?
> Or some pathces for "mkisofs" is?

How about a patch to mkhybrid?  I was just writing a script to automate
this when somebody passed me Troy B.'s patch to mkhybrid (which is the
correct place to put this support).  It supports multiple boot images (up
to four) with no problem.  Note: do not give it a symlink to your boot
image!  It screws the absolute offset calculation which cost me many hours
before I realized what was happening.  Also, there is a bug which causes
fwrite to fail on certain sized smaller isofs's (haven't found the exact
pattern yet).

I've attach the patch to this message.

[ deleted because it's too big; ask Matt to put it on an ftp site if you
want it -- dw ]

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
