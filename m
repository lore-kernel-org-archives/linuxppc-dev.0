Message-ID: <3BC5B53F.2090205@ymail.ch>
Date: Thu, 11 Oct 2001 17:05:35 +0200
From: Stefan Wanner <stefan.wanner@ymail.ch>
MIME-Version: 1.0
To: Olaf Hering <olh@suse.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: vfat on bigendian
References: <3BC5AE61.5060700@ymail.ch> <20011011164253.A27332@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


thanks a lot!!!

now it works fine.

stefan


Olaf Hering wrote:

> On Thu, Oct 11, Stefan Wanner wrote:
>
>
>>hi
>>
>>i tried the patch you posted today:
>>http://lists.linuxppc.org/linuxppc-dev/200110/msg00075.html
>>
>>now, i can read files with long names created on windows. but it's no
>>more possible to create files on the linux system (also 8.3 names). they
>>apear on linux as ????.
>>
>>any idea?
>>
>
> Alan has the patch.
> /mirror/SuSE/ftp.suse.com/pub/suse/ppc/kernel/BETA/patches/70__2.4.5-pre1_vfat_direntry_endianfix.diff.gz
>
>
>
> Gruss Olaf
>
> --
>  $ man clone
>
> BUGS
>        Main feature not yet implemented...
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
