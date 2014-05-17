Return-Path: <intermediadc@hotmail.com>
Received: from blu0-omc3-s26.blu0.hotmail.com (blu0-omc3-s26.blu0.hotmail.com
 [65.55.116.101]) by ozlabs.org (Postfix) with ESMTP id BB13C140090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 May 2014 18:28:50 +1000 (EST)
Message-ID: <BLU436-SMTP260B93781C0F77CDD26FD4AC8300@phx.gbl>
Date: Sat, 17 May 2014 10:28:43 +0200
From: Luigi Burdo <intermediadc@hotmail.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: G5 Quad working with Linux PPC and RadeonHD
References: <BLU436-SMTP80159B93A5EE9CE9979A56C8310@phx.gbl>
 <5376DD44.4040402@daenzer.net>
In-Reply-To: <5376DD44.4040402@daenzer.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michel D=C3=A4nzer thanks for your explanation about .
About the first post

https://bugs.freedesktop.org/show_bug.cgi?id=3D72877

Christian (Xeno74) had been success to have the right mesa/gl colors on
X1000 machine he make a patch about =2C i tested his package on QuadG5
but no effect probably something is different in kernel/hardware (?!?)

about the second
on X1000 r600 boards dont gave decoration problems
there is probably needed some other trick about
for the other architecture.

https://bugs.freedesktop.org/show_bug.cgi?id=3D74939


In any way thanks alot for the infos and for the works
the PPC linux staff is doing :)

Luigi

Il 17/05/14 05:53=2C Michel D=C3=A4nzer ha scritto:
> On 16.05.2014 19:31=2C Luigi Burdo wrote:
>> Hi all i start one week ago to write massage in ubuntu about
>> my object i have  Radeon Hd working on my Quad G5 thanks to linuxPPC .
>>
>> But there are some things to fix
>> One RadeonHD mesa colors are wrong .
> See https://bugs.freedesktop.org/show_bug.cgi?id=3D72877 . No progress ye=
t
> unfortunately.
>
>
>> On RadeonHD 4650 ddr3 512mb i have full video acceleration and hdmi
>> audio working
>> On RadeonHD 6570 ddr3 2048mb i have video but no chars on windows and
>> icons .
> The latter sounds like
> https://bugs.freedesktop.org/show_bug.cgi?id=3D74939 =2C which is fixed i=
n
> http://cgit.freedesktop.org/xorg/driver/xf86-video-ati/commit/?id=3D8da17=
f30c70f4494ce22ad781a1cee17041812f3
> .
>
>
