Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DAB412C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Dec 2013 09:05:35 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: 3.13-rc1: eth0 hw csum failure on powerpc
References: <alpine.DEB.2.11.1311300156380.31521@trent.utfs.org>
 <alpine.DEB.2.11.1311300210360.31521@trent.utfs.org>
 <alpine.DEB.2.11.1311301314220.31521__48727.6146108799$1385846242$gmane$org@trent.utfs.org>
Date: Sat, 30 Nov 2013 23:05:14 +0100
In-Reply-To: <alpine.DEB.2.11.1311301314220.31521__48727.6146108799$1385846242$gmane$org@trent.utfs.org>
 (Christian Kujau's message of "Sat, 30 Nov 2013 13:16:34 -0800 (PST)")
Message-ID: <87vbz9pmud.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christian Kujau <lists@nerdbynature.de> writes:

> On Sat, 30 Nov 2013 at 02:11, Christian Kujau wrote:
>> On Sat, 30 Nov 2013 at 02:07, Christian Kujau wrote:
>> > while trying to upgrade from 3.12.0 to 3.13-rc1 or -rc2, the following 
>> > happens early during bootup:
>> > 
>> > [...]
>> >  Freeing unused kernel memory: 204K (c06ea000 - c071d000)
>> >  eth0: hw csum failure
>> >  CPU: 0 PID: 0 Comm: swapper Not tainted 3.13.0-rc2 #1
>> >  Call Trace:
>> 
>> Btw, full dmesg & .config:  http://nerdbynature.de/bits/3.13-rc1/
>
> Oh, this has already been reported earlier this week:
>
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-November/113584.html

No solution yet, though, 3.13-rc2 is still broken.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
