Mime-Version: 1.0
Message-Id: <v04220801b4b408f03c28@[192.168.1.5]>
In-Reply-To: <388E53BA.5DC43A02@erols.com>
References: <200001260144.UAA27868@shell.faradic.net>
 <388E53BA.5DC43A02@erols.com>
Date: Tue, 25 Jan 2000 20:36:56 -0600
To: Nelson Abramson <pogtal@erols.com>
From: Justin Shore <macdaddy@vinnie.ksu.ksu.edu>
Subject: Re: Adaptec PowerDomain 29160N supported?
Cc: jingai@floatingpenguins.com, linuxppc-user@lists.linuxppc.org,
        linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:54 PM -0500 1/25/00, Nelson Abramson wrote:
>jingai wrote:
>
>  > I'm ready to purchase an adaptec scsi card to replace my initio miles
>  > (doesn't work under linux/ppc), and I noticed that the 29160N is around the
>  > same price as the 2940UW... so, my question is, is it supported under
>  > LinuxPPC?  and what exactly makes it 160MB/s?  if anyone else owns this
>  > card, I'd like to hear your impressions..

I have an Adaptec 2940U2W, the one that has recently been
discontinued.  Its an excellent card and is supported by LPPC.  Even
a 2940UW is a good card if you have the UW drives for it.  I have yet
to use a 29160N but I imagine it will be quality.  I don't if LPPC
can support it right now though.  I'll leave that for someone else to
answer.  Unfortunately the 2940U2W costs more than the 29160N, even
though it has been discontinued.  Nuts.

<snip>

>standards capable of hitting 160mb/s are u2w lvd, which means that they have a
>huge bandwith, and use extremely low amounts of energy  Only u2w lvd drives
>can get anywhere near that amount of data transfer, and the chain is only as
>fast as your slowest device, so if you are migrating a regular ole scsi narrow
>drive onto a u2w lvd chain, it's only going to go at scsi narrow speeds, which
>is about 10mb/s max.

On a side note, the 2940U2W utilizes SpeedFlex technology.  In other
words you can put any speed of SCSI drive on one of its buses and it
won't slow the bus down to the speed of the slowest device.  Very
nice indeed.  I have no idea if the 29160N supports it or not though.
Other Adaptec cards did and its their patent so it may very well.

HTH
  Justin


PS==>Asking the same question on both the -dev and -user lists is
damn annoying.  If one doesn't know, the other probably won't either
since many are on the both lists.  FYI


--
Justin Shore
K-State Linux Distro Mirror, Sysadmin
macdaddy@vinnie.ksu.ksu.edu
<http://vinnie.ksu.ksu.edu/mirror/rpm2html>
<ftp://vinnie.ksu.ksu.edu/pub/mirror/linux>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
