Date: Wed, 5 Apr 2000 08:32:12 +0200
From: Olaf Hering <olh@suse.de>
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Setting up yaboot
Message-ID: <20000405083212.B7710@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <200004040459.XAA03713@lists.linuxppc.org> <38EA7D15.C453ED94@uncc.edu> <38EACD97.113001FE@dana.ucc.nau.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <38EACD97.113001FE@dana.ucc.nau.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Apr 04, Tim Wojtulewicz wrote:

>
> Is there some sort of instructions to setting up yaboot?  I managed to
> get LinuxPPC 2000 installed on my Pismo, and I'd like to actually be able
> to use it now.  Here's how I have the partitions set up.

There is the suseboot.hqx at
ftp://ftp.suse.com/pub/suse/ppc/update/BETA/
docs are included.

> hda9 -> 2gb MacOS partition (HFS+)
> hda10 -> 32mb HFS partition
> hda11 -> 128mb swap
> hda12 -> Rest of drive is linux "/"
>
> Don't ask me why the partition numbers are so high, cuz I don't know.
> Any help offered would be appreciated.

A pdisk -l will show you many system partitions for drivers etc. 8
System Partitions is very high, yes.


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
