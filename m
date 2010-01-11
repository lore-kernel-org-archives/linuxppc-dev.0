Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5AB3C1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 07:43:05 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 02/13] powerpc/5200: LocalPlus driver: use SCLPC register
	structure
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220759.23453.roman.fietze@telemotive.de>
	<fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
Date: Mon, 11 Jan 2010 21:43:02 +0100
Message-Id: <20100111204302.B42B23F6DA@gemini.denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Grant,

In message <fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com> you wrote:
> 
> Please don't.  I know that a lot of other 5200 code uses register map
> structures in this way, but I consider it bad practice.  I coded this

May I ask _why_ you consider this bad practice?

Is a structure not the most natural way to encode the specifics of a
hardware interface (address offet, bus width, etc.) in C?

What do you recommend instead?  Using lists of register offsets
(without any type information) as for example ARM is doing?

> driver without a structure for a reason.  The reason I haven't removed

Could you please explain this reason?


I'm trying to understand if this is a MPC52xx specific reasoning, or
if you apply this to all of PowerPC, or generally to all kernel code?

And: is this just your personal preferences, or generally agreed on?

Thanks in advance, and sorry for asking stupid questions, but your
reply surprised me...

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Gods don't like people not doing much work. People  who  aren't  busy
all the time might start to _think_.  - Terry Pratchett, _Small Gods_
