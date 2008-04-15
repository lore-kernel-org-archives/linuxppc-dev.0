Return-Path: <dzu@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6F54BDE8FB
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 01:51:29 +1000 (EST)
From: Detlev Zundel <dzu@denx.de>
To: joakim.tjernlund@transmode.se
Subject: Re: Signal backtrace function
References: <1207764980.5826.77.camel@gentoo-jocke.transmode.se>
	<m2skxoo1ur.fsf@ohwell.denx.de>
	<1208190010.5911.15.camel@gentoo-jocke.transmode.se>
Date: Tue, 15 Apr 2008 17:50:45 +0200
In-Reply-To: <1208190010.5911.15.camel@gentoo-jocke.transmode.se> (Joakim
	Tjernlund's message of "Mon, 14 Apr 2008 18:20:09 +0200")
Message-ID: <m2zlrvi0bu.fsf@ohwell.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jocke,

> On Mon, 2008-04-14 at 18:09 +0200, Detlev Zundel wrote:
>> Hi Jocke,
>> 
>> > I made my own backtrace function for printing
>> > a trace from within a signal handler. Maybe it
>> > can be useful for the kernel too? General
>> > comments welcome.
>> 
>> Probably a dumb question, but doesn't backtrace(3) from glibc work
>> architecture independent already?   Why do you need to reimplement it?
>
> Nope, it doesn't give you a good backtrace from within a signal handler.
> On x86 you can use the normal backtrace function with a minor
> workaround, but as ppc doesn't save a FP in leaf functions, that
> workaround does not work well. You can read more about it
> at http://www.linuxjournal.com/article/6391

Thanks for clearing that up.  I wasn't aware of that limitation.

Cheers
  Detlev

-- 
In short: much of our country's [USA] counterterrorism security spending is
not designed to protect us from the terrorists,  but instead to protect our
public officials from criticism when another attack occurs.
                                   -- Bruce Schneier
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
