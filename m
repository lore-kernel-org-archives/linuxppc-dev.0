Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f187.google.com (mail-yw0-f187.google.com
	[209.85.211.187]) by ozlabs.org (Postfix) with ESMTP id 7836F1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 28 Nov 2009 14:57:19 +1100 (EST)
Received: by ywh17 with SMTP id 17so1991844ywh.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 19:57:17 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa40911271956j2d409c5ak4198964e523d8dee@mail.gmail.com>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-13-git-send-email-albert_herranz@yahoo.es>
	<F5450BB0-FBBB-48D5-A054-CB147FD43EAA@kernel.crashing.org>
	<4B0D6837.4020407@yahoo.es>
	<76CF44C1-3CC1-43B5-958D-E1A7984A44A9@kernel.crashing.org>
	<4B0EFC1D.5030806@yahoo.es>
	<BBB65A84-B871-474F-8666-90CCD10D90B6@kernel.crashing.org>
	<1259357718.2076.7.camel@pasglop>
	<fa686aa40911271956j2d409c5ak4198964e523d8dee@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 27 Nov 2009 20:56:57 -0700
Message-ID: <fa686aa40911271956w7b8fff7av8473aabfc56515ff@mail.gmail.com>
Subject: Re: [RFC PATCH 12/19] powerpc: gamecube: platform support
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 27, 2009 at 8:56 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Fri, Nov 27, 2009 at 2:35 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Fri, 2009-11-27 at 01:09 +0100, Segher Boessenkool wrote:
>>> >>> We need it as it currently doesn't match with the default bus ids.
>>> >>
>>> >>> Should I introduce a .type property matching any of those above
>>> >>> in the
>>> >>> soc node, and get rid of the explicit bus probe?
>>> >>
>>> >> You don't need any fake bus as far as I can see, just probe the
>>> >> devices
>>> >> you want.
>>> >
>>> > But it's way easier to let the bus probe do it for us. I don't see
>>> > the win here.
>>>
>>> As long as this doesn't leak into the device tree in any way, I don't
>>> care. =A0How's that? :-)
>>
>> I still like having the node that encloses all the devices. Not sure
>> why, but I like it :-)
>
> I do to. =A0It documents that all these things are enclosed in a single
> package and provides grouping device nodes with nodes describing
> shared registers and the like.

And for the same reason I keep all my socks in the same drawer.  :-)

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
