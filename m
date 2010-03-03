Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id BAE12B7CC1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 21:10:19 +1100 (EST)
Received: from mailgw1.invitel.net (mailgw1.invitel.net [91.82.208.34])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	432BD11A804
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 11:10:15 +0100 (CET)
Date: Wed, 03 Mar 2010 11:10:10 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
In-reply-to: <OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-id: <4B8E3582.8060003@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Joakim,

Joakim Tjernlund wrote:
> Heiko Schocher <hs@denx.de> wrote on 2010/03/03 09:02:47:
[...]
>> Here the results:
>> (The first 4 rows are the results for the kernel without your patches,
>>  the next 4 rows are the results for the kernel with your patches)
>>
>> make[1]: Entering directory `/home/hs/lmbench-3.0-a9/results'
> 
> I see both ups and downs in this test, don't quite understand why.
> What is your config w.r.t SWAP, MODULES, CPU6 and CPU15?

Sorry, forgot to say, where to find the sources. You can find them
here:

http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/tqm8xx

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
