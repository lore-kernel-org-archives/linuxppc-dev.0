Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1E351B7D15
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Mar 2010 17:30:28 +1100 (EST)
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <OF1413A940.58E7B20E-ONC12576E0.003A9000-C12576E0.003ACFB7@transmode.se>
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
	<OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
	<4B8F8BB4.6070201@denx.de>
	<20100304121656.6758A28BBC@gemini.denx.de>
	<OF22F52BE0.FB3F104E-ONC12576DC.00469DB5-C12576DC.004808C4@transmode.se>
	<4B8FE00F.4030405@denx.de>
	<OF342998FA.F0D2DAE1-ONC12576DD.003A3D7E-C12576DD.003AA365@transmode.se>
	<4B94AB55.3020308@denx.de>
	<OF7533FA9E.2786BF7B-ONC12576E0.002FB5D8-C12576E0.002FFEE9@transmode.se>
	<4B94BE1F.8030203@denx.de>
	<OF1413A940.58E7B20E-ONC12576E0.003A9000-C12576E0.003ACFB7@transmode.se>
Date: Tue, 09 Mar 2010 07:30:24 +0100
Message-Id: <20100309063024.B603EEA5BDA@gemini.denx.de>
Cc: Scott Wood <scottwood@freescale.com>, hs@denx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Joakim Tjernlund,

In message <OF1413A940.58E7B20E-ONC12576E0.003A9000-C12576E0.003ACFB7@transmode.se> you wrote:
>
> > I use NFS.
> 
> Then I think it is possible NFS gets in the way for stable measurements. Anyone
> have experience with running lmbench on NFS?

NFS may have some influence here, but I doubt it is the primary cause
for these variations. The network where Heiko is running these tests
is mostly idle, so it should provide fairly constant conditions. Of
coursem the use of the network on the MPC8xx itself will add to the
variation, but again I would not expect so big differences.

Heiko - there is a 10 GB disk attached to the "tqm8xx" system; I
think there should be a usable root file system on it, but I cannot
remember the actual state. Maybe we can use that. Please contact me
on jabber this afternoon!

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Living on Earth may be expensive, but it includes an annual free trip
around the Sun.
