Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id 0B6CEB6F1B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:59:41 +1100 (EST)
Received: by yxe9 with SMTP id 9so10898547yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 11:59:40 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B4B7F13.3090809@freescale.com>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220759.23453.roman.fietze@telemotive.de>
	<fa686aa41001111115g3451c9b9h4d6c551afd5698e1@mail.gmail.com>
	<4B4B7F13.3090809@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 12:59:20 -0700
Message-ID: <fa686aa41001111159n664b3d44m7375b4632e196590@mail.gmail.com>
Subject: Re: [PATCH 02/13] powerpc/5200: LocalPlus driver: use SCLPC register
	structure
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, Roman Fietze <roman.fietze@telemotive.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 11, 2010 at 12:42 PM, Scott Wood <scottwood@freescale.com> wrot=
e:
> Grant Likely wrote:
>>
>> Please don't. =A0I know that a lot of other 5200 code uses register map
>> structures in this way, but I consider it bad practice. =A0I coded this
>> driver without a structure for a reason. =A0The reason I haven't removed
>> the other 5200 register map structures is the code impact would be
>> huge, it would probably cause breakage, and it would break all
>> out-of-tree patches touching the same code for no measurable
>> advantage.
>
> FWIW, over on the U-Boot side patches are getting NACKed by Wolfgang if t=
hey
> don't use register structures. :-P
>
> They're nice from a type-safety and namespacing perspective, though they =
get
> ugly pretty quickly if there are gaps.

Regardless, I see no reason to change existing code in either direction.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
