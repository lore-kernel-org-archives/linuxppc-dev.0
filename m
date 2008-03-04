Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CB285DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 04:01:12 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JWaVj-0000YW-Ex
	for linuxppc-embedded@ozlabs.org; Tue, 04 Mar 2008 17:01:03 +0000
Received: from p5497fb5c.dip.t-dialin.net ([84.151.251.92])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 04 Mar 2008 17:01:03 +0000
Received: from dzu by p5497fb5c.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 04 Mar 2008 17:01:03 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: ELDK on 64-bit host
Date: Tue, 04 Mar 2008 18:00:56 +0100
Message-ID: <m2fxv65sqf.fsf@ohwell.denx.de>
References: <a425f86c0802200703x6cbbd5acwa4b3a8dda455eeea@mail.gmail.com>
	<f8328f7c0802200749h7a761fffha636f292b54182e5@mail.gmail.com>
	<Pine.LNX.4.64.0802201807340.7503@pc-213-140-179-32.aina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kalle,

> On Wed, 20 Feb 2008, Ben Warren wrote:
>
>> On Wed, Feb 20, 2008 at 10:03 AM, Kalle Pokki <kalle.pokki@eke.fi> wrote:
>> > Hi,
>> >
>> >  I tried to copy the ELDK 4.0 installation I had to a new Core 2 Quad
>> >  machine running 64-bit Ubuntu 7.10, but the new machine refuses to
>> >  execute the cross compiler. Has anyone succeeded in running ELDK in
>> >  this kind of environment?
>> >
>> Yes (at least with 64-bit Debian on a single core Xeon), but you need
>> a special library on the host.  I think it's call 'ia32-libs'.  It
>> should be available via aptitude.
>
> Thanks, that was indeed the correct library to install. Now it works just 
> fine.
>
> I'm a bit surprised there wasn't really any useful search results from 
> Google with obvious keywords. I was already about to install the 32-bit 
> version of Ubuntu to get the compiler working again. But then, perhaps 
> installing this library was obvious to everyone else :)

We added an FAQ entry[1] to our DULG documentation.  And just as a
reminder, there is also an ELDK mailing list for such questions[2].

Cheers
  Detlev

[1] http://www.denx.de/wiki/DULG/ELDKUsageIn64BitEnvironment
[2] http://lists.denx.de/mailman/listinfo/eldk

-- 
Paul Simon sang "Fifty Ways to Lose Your Lover", because quite
frankly, "A Million Ways to Tell a Developer He Is a D*ckhead"
doesn't scan nearly as well.  But I'm sure he thought about it.
                            -- linux/Documentation/ManagementStyle
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
