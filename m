Message-ID: <39632985.5BE39349@relog.ch>
Date: Wed, 05 Jul 2000 14:26:45 +0200
From: Michel Dänzer <daenzer@relog.ch>
Reply-To: daenzerm@student.ethz.ch
MIME-Version: 1.0
CC: Andrew Clausen <clausen@gnu.org>, linuxppc-dev@lists.linuxppc.org,
        GNU Parted list <parted@gnu.org>,
        linux-apus-user@lists.sourceforge.net
Subject: Re: GNU Parted, linuxppc support coming :-)
References: <39625AB3.6A5447CE@gnu.org> <39632512.1953DBAA@amulet.co.jp>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andrew Clausen wrote:
>
> I'm trying to support the Mac partition map, but I'll need some help,
> since I don't have a PowerPC :-(
>
> Could someone send me their partition map?  You can get this with:
>
>         # dd if=/dev/hda bs=512 count=MAP-SIZE | gzip | map.gz
>
> If you don't know how big your partition map (+1 for driver block) is,
> then 64 should do (?).  (What's a reasonable size for a partition
> map?)

Does parted support Amiga partition maps? If not, I'm sure APUS users will
gladly send you their partition maps...


Michel


--
UNIX is like Sex:
If you don't know it, you don't miss it. But if you know it, you'll need it.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
