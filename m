Message-Id: <v03130323b331b3926f46@[17.202.21.235]>
In-Reply-To: <Pine.LNX.4.10.9904071947110.15881-100000@beer.pub.umich.edu>
References: <Pine.LNX.3.96.990407183923.5918B-100000@globegate.utm.edu>
MIME-Version: 1.0
Date: Wed, 7 Apr 1999 18:16:22 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Peter Bierman <bierman@apple.com>
Subject: Re: Mac OS X Server Filesystem Format
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> has anybody tried to mount any of the Mac OS X Server CDs inside linux?
>> I assume they have a BSD format... Mounting auto doesn't work with the
>> CDs.   With ALL Linux filesystems enabled in the kernel, what mount
>> options would I use to get the CD to mount?
>
>I'm surprised they're not ISO-9660... but if they're really a bsd
>filesystem, you'd technically be looking for ffs, but I think linux still
>calls it ufs....  :-)

>It's not on a _partition_ on the CD, by any chance, is it?  Does pdisk
>show a partition map?  If so, it could be a bit of a pain....  We run into
>trouble with that under MkLinux a lot when people misburn the hybrid CD as
>ISO-9660 in a mac-style partition....  Dunno, just a thought.  :-)


It's a UFS filesystem inside an "Apple_Rhapsody_UFS" partition entry.

It should be a BSD compatible UFS filesystem.

It is *not* a multisession CD.

-pmb

--
"UNIX shells in Mac OS X should be unneeded but functional...
                        and have the same installed base as MPW."



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
