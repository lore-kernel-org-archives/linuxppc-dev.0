Date: Thu, 11 Oct 2001 16:42:53 +0200
From: Olaf Hering <olh@suse.de>
To: Stefan Wanner <stefan.wanner@ymail.ch>
Cc: linuxppc-dev@lists.linuxppc.org, dpates@dsdk12.net
Subject: Re: vfat on bigendian
Message-ID: <20011011164253.A27332@suse.de>
References: <3BC5AE61.5060700@ymail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BC5AE61.5060700@ymail.ch>; from stefan.wanner@ymail.ch on Thu, Oct 11, 2001 at 04:36:17PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 11, Stefan Wanner wrote:

>
> hi
>
> i tried the patch you posted today:
> http://lists.linuxppc.org/linuxppc-dev/200110/msg00075.html
>
> now, i can read files with long names created on windows. but it's no
> more possible to create files on the linux system (also 8.3 names). they
> apear on linux as ????.
>
> any idea?

Alan has the patch.
/mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/patches/70__2.4.5-pre1_vfat_direntry_endianfix.diff.gz



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
