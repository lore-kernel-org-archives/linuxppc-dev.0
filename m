From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IBM 440GX performance (was Re: IBM 440GX, Ocotea...)
Date: Thu, 25 Mar 2004 09:02:54 +0100
References: <20040323183122.GA6724@gate.ebshome.net> <4057CCD40004167A@mssbzhh-int.msg.bluewin.ch> <20040324234025.GA11675@gate.ebshome.net>
In-Reply-To: <20040324234025.GA11675@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403250902.54382.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Eugene,

thanks for the benchmarks, but I was somewhat surprised to find results with
enabled L2 cache. Does this mean, that there is some existing revision
with working L2 cache, or is it only enabled to demonstrate how fast it could
be if this thing is working correctly?

Ciao,
  Gerhard


On Thursday 25 March 2004 00:40, Eugene Surovegin wrote:
> On Wed, Mar 24, 2004 at 09:59:56AM +0100, Wolfgang Grandegger wrote:
> > BTW, do you or somebody else have some performance figures
> > (LMbench?) for the GX compared to the other processor.
>
> I did some testing on our custom 440GP/GX hardware.
>
> Each system has 512M of RAM, SCSI disk was used for disk and FS testing (in
> RAID-1 configuration but without a mirror drive).
>
> I used NFS root, host - P4 1.6GHz, SuSE 8.0, 100Mbit switch connection.
>
> 440GP system was running at 400MHz/133MHz, 440GX - 500MHz/166MHz. For 440GX
> I did testing with L2C disabled and enabled.
>[SNIPSNAP]


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
