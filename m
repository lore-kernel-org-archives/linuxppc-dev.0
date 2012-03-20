Return-Path: <jbarnes@virtuousgeek.org>
Received: from oproxy7-pub.bluehost.com (oproxy7.bluehost.com
 [IPv6:2605:dc00:100:2::a7])
 by ozlabs.org (Postfix) with SMTP id BA58BB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 11:37:47 +1100 (EST)
References: <20120309142555.7ec5e0ac@kryten>
 <1331263785.3105.52.camel@pasglop> <20120309144645.5b5997d2@kryten>
 <20120309102846.51f0df89@jbarnes-x220>
 <20120315110516.4112fe49dac537b52d4ddc25@canb.auug.org.au>
In-Reply-To: <20120315110516.4112fe49dac537b52d4ddc25@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: 3.3.0-rc6-next-20120308 boot failure on POWER7 blade
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Mon, 19 Mar 2012 17:37:48 -0700
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <1075f6c8-ed56-45a8-b8ac-fba8fd53a42a@email.android.com>
Cc: linuxppc-dev@lists.ozlabs.org, yinghai@kernel.org,
 Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

>Hi Jesse,
>
>On Fri, 9 Mar=
 2012 10:28:46 -0800 Jesse Barnes
><jbarnes@virtuousgeek.org> wrote:
>>
>> =
On Fri, 9 Mar 2012 14:46:45 +1100
>> Anton Blanchard <anton@samba.org> wrot=
e:
>> 
>> > > Looks like something that got fixed but the new patches from
=
>Bjorn
>> > > aren't in next yet. I'll fwd you the patch separately to appl=
y on
>> > > top of what you have see if that helps (to confirm that's indee=
d
>the
>> > > issue).
>> > 
>> > Thanks, confirmed that it fixes it. Patch =
below in case anyone else
>is
>> > hitting it.
>> > 
>> > --
>> > 
>> > On =
Sat, 2012-03-03 at 08:52 +1100, Benjamin Herrenschmidt wrote:
>> > 
>> > > =
Or give me a chance to dig :-) I'll have a look next week.
>> > 
>> > This =
is indeed what bjorn suspected on irc, this patch fixes it:
>> > 
>> > (Bjo=
rn, please fold it in the original offending patch)
>> 
>> Thanks guys; I'l=
l push the fixes to -next when I get to a real
>network
>> (at the airport =
now about to run out of battery with a crappy
>> connection).
>
>Ping?
>
>I=
 am also still carrying the build fix for
>arch/powerpc/kernel/pci-common.c=

>since Feb 27.
>
>-- 
>Cheers,
>Stephen Rothwell                    sfr@ca=
nb.auug.org.au
>http://www.canb.auug.org.au/~sfr/

Arg yeah I'll apply the =
fixups before sending the pull req. This trip has been a nightmare (14+ hou=
r work days and no connectivity and a week longer than expected) but it's f=
inally over, and just in time! 

Jesse
-- 
Jesse Barnes, Intel Open Source =
Technology Center
