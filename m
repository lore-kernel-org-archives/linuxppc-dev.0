Mime-Version: 1.0
Message-Id: <v04220801b58c9d72e07f@[10.0.0.42]>
In-Reply-To: <20000707210726.C7162@plato.local.lan>
References: <20000705130158.A18557@drow.them.org>
 <200007060537.HAA01020@piglet.grunz.lu>
 <20000707210726.C7162@plato.local.lan>
Date: Sat, 8 Jul 2000 01:58:52 -0700
To: Ethan Benson <erbenson@alaska.net>, Michel Lanners <mlan@cpu.lu>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: GNU Parted, linuxppc support coming :-)
Cc: linuxppc-dev@lists.linuxppc.org, clausen@gnu.org, parted@gnu.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 9:07 PM -0800 7/7/00, Ethan Benson wrote:
>On Thu, Jul 06, 2000 at 07:37:34AM +0200, Michel Lanners wrote:
>>
>>  Hi all,
>>
>>  >> Excuse my ignorance... what FS's do people usually use with MacOS?
>>  >> HFS/HFS+?
>>
>>  Something  wanted to add to a previous mail in the thread:
>>
>>  Don't forget that there are lots of Macs that _absolutely_ need at least
>>  one HFS partition and an Aple partition map on one of there disks,
>>  because that's the only thing the ROM can boot some OS from.
>>
>>  AFAICT, all pre-NewWorld machines are in this case, except maybe some
>>  that can be tweaked to network boot...
>
>oldworld macs this is true i think.

Not completely true.  They do have to have a Mac partition table but
I'm pretty sure you can get away without any HFS partitions if you
use quik to boot.  Granted, that's a pain, but it can be done.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
