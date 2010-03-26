Return-Path: <r.goyet@gmail.com>
Received: from mail-fx0-f221.google.com (mail-fx0-f221.google.com
	[209.85.220.221]) by ozlabs.org (Postfix) with ESMTP id E76CDB7CC2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 21:20:56 +1100 (EST)
Received: by fxm21 with SMTP id 21so414870fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Mar 2010 03:20:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1269509341.441.2779.camel@thor.local>
References: <8028e5751003240332h3f13c2d5w941dda44b4740d7@mail.gmail.com>
	<1269509341.441.2779.camel@thor.local>
Date: Fri, 26 Mar 2010 11:20:53 +0100
Message-ID: <8028e5751003260320i37fee6a9l74379c3279850c9e@mail.gmail.com>
Subject: Re: Booting headless PowerMac G5
From: Romain Goyet <r.goyet@gmail.com>
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/3/25 Michel D=C3=A4nzer <michel@daenzer.net>:
> On Wed, 2010-03-24 at 11:32 +0100, Romain Goyet wrote:
>>
>> =C2=A0 Here's a summary about "how to boot a PowerMac G5 without a scree=
n
>> attached". As many people have noticed, default yaboot install won't
>> boot unless a screen is attached.
>>
>> =C2=A0 Actually, the workaround is really simple. Thing is, that's the
>> "ofboot.b" script that messes things up. This script is a "bridge",
>> that actually either starts yaboot or let you boot off of a CD. I
>> don't know what's the point, since OpenFirmware already lets you boot
>> off of the CD by pressing C on boot=E2=80=A6
>>
>> =C2=A0 So basically, to boot headless, all you have to do is to tell
>> OpenFirmware to boot straight off the yaboot binary, and to skip the
>> ofboot.b
>> Just boot into OpenFirmware (Command-Option-O-F), and type :
>> setenv boot-device hd:2,yaboot (where 2 is the number of the partition
>> containing yaboot)
>> boot
>>
>> And here you go, you can unplug that useless monitor :-)
>>
>> References :
>> http://saintaardvarkthecarpeted.com/blog/archive/2005/02/THE_WINE_OF_BOO=
T.html
>> http://grub.enbug.org/TestingOnPowerPC
>
> That's good to know, thanks.
>

You're welcome. Actually I also wrote this as a memo for myself :-)

>
>> By the way, as of writing this, grub2 on PPC from debian gives a "out
>> of memory" issue. Known bug.
>
> That's on the G5? It's working on my PowerBook, but I haven't updated
> the grub2 binaries on the bootstrap partition in a while...
>
>


Yeah, that's on a PowerMac QuadG5.
I think that's a known issue :
http://www.mail-archive.com/grub-devel@gnu.org/msg04455.html
However it might be another one since it's working for you. I'm using
grub2 from Debian stable.


> --
> Earthling Michel D=C3=A4nzer =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.vmware.com
> Libre software enthusiast =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0Debian, X and DRI developer
>
>
>
>
>
>
