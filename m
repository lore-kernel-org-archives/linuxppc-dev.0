Message-Id: <200007102219.AAA00856@piglet.grunz.lu>
Date: Tue, 11 Jul 2000 00:19:27 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: GNU Parted, linuxppc support coming :-)
To: tas@mindspring.com
cc: erbenson@alaska.net, linuxppc-dev@lists.linuxppc.org, clausen@gnu.org,
        parted@gnu.org
In-Reply-To: <v04220801b58c9d72e07f@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   8 Jul, this message from Timothy A. Seufert echoed through cyberspace:
>>>  Don't forget that there are lots of Macs that _absolutely_ need at least
>>>  one HFS partition and an Aple partition map on one of there disks,
>>>  because that's the only thing the ROM can boot some OS from.
>>>
>>>  AFAICT, all pre-NewWorld machines are in this case, except maybe some
>>>  that can be tweaked to network boot...
>>
>>oldworld macs this is true i think.
>
> Not completely true.  They do have to have a Mac partition table but
> I'm pretty sure you can get away without any HFS partitions if you
> use quik to boot.  Granted, that's a pain, but it can be done.

You are right. OF only accesses the boot block of a partition marked
bootable. It probably doesn't know filesystems at all.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
