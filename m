Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by lists.ozlabs.org (Postfix) with ESMTP id 70E111A0191
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 12:42:01 +1100 (AEDT)
Subject: Re: PowerPC agpmode issues
To: Mike <michael.heltne@gmail.com>,
 Boris Reinhard <reinhard.boris@googlemail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <56B865A0.4060707@daenzer.net>
 <CAK90Sjk-AXekt_WKSk53GUeUZk-T4WhrwoNuwPA5N4pX2OPceA@mail.gmail.com>
 <CANtoAtPoYodsC3u-BOi8HM=ew03CX32BBKvFXwZJ4wbSkMWRZQ@mail.gmail.com>
Cc: "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 Pranith Kumar <bobby.prani@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <56B943E3.1010407@daenzer.net>
Date: Tue, 9 Feb 2016 10:41:55 +0900
MIME-Version: 1.0
In-Reply-To: <CANtoAtPoYodsC3u-BOi8HM=ew03CX32BBKvFXwZJ4wbSkMWRZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.02.2016 22:28, Mike wrote:
> Certainly 750~800 fps in glxgears vs 3000+ in debian squeeze, i cant
> bring myself to say that it's an acceptable situation no matter how
> tired i am of the problem knowing how well the setup could do. It's
> clear that the implementation is broken for everything but x86, [...]

Why is that? It was working fine on my last-gen PowerBook. AFAIK Darwin
/ OS X never used anything but a static AGP GART mapping though, so it
seems very likely that the issues with older UniNorth revisions are
simply due to the hardware being unable to support the usage patterns of
modern GPU drivers.

That said, if you guys have specific suggestions for a "proper"
solution, nobody's standing in your way.


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
