Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
 by ozlabs.org (Postfix) with ESMTP id 32AF514009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 May 2014 14:02:46 +1000 (EST)
Message-ID: <5376DD44.4040402@daenzer.net>
Date: Sat, 17 May 2014 12:53:40 +0900
From: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>
MIME-Version: 1.0
To: Luigi Burdo <intermediadc@hotmail.com>
Subject: Re: G5 Quad working with Linux PPC and RadeonHD
References: <BLU436-SMTP80159B93A5EE9CE9979A56C8310@phx.gbl>
In-Reply-To: <BLU436-SMTP80159B93A5EE9CE9979A56C8310@phx.gbl>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16.05.2014 19:31, Luigi Burdo wrote:
> Hi all i start one week ago to write massage in ubuntu about
> my object i have  Radeon Hd working on my Quad G5 thanks to linuxPPC .
> 
> But there are some things to fix
> One RadeonHD mesa colors are wrong .

See https://bugs.freedesktop.org/show_bug.cgi?id=72877 . No progress yet
unfortunately.


> On RadeonHD 4650 ddr3 512mb i have full video acceleration and hdmi
> audio working
> On RadeonHD 6570 ddr3 2048mb i have video but no chars on windows and
> icons .

The latter sounds like
https://bugs.freedesktop.org/show_bug.cgi?id=74939 , which is fixed in
http://cgit.freedesktop.org/xorg/driver/xf86-video-ati/commit/?id=8da17f30c70f4494ce22ad781a1cee17041812f3
.


-- 
Earthling Michel Dänzer            |                  http://www.amd.com
Libre software enthusiast          |                Mesa and X developer
