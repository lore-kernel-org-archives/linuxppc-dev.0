Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id D586DDDFB2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:47:03 +1000 (EST)
Received: by gxk20 with SMTP id 20so793388gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:47:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506221648.E98A683420E8@gemini.denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-6-git-send-email-wd@denx.de>
	<fa686aa40905061340s212385b1r8be4e2f7505bd0a0@mail.gmail.com>
	<20090506221648.E98A683420E8@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 16:46:42 -0600
Message-ID: <fa686aa40905061546h3df6dac5hf19080627153080c@mail.gmail.com>
Subject: Re: [PATCH 05/12] mpc5121ads: Added Reset Module node to DTS.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 4:16 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant Likely,
>
> In message <fa686aa40905061340s212385b1r8be4e2f7505bd0a0@mail.gmail.com> =
you wrote:
>> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
>> > From: Piotr Ziecik <kosmo@semihalf.com>
>> >
>> > Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
>> > Signed-off-by: Wolfgang Denk <wd@denx.de>
>> > Cc: Grant Likely <grant.likely@secretlab.ca>
>> > Cc: John Rigby <jcrigby@gmail.com>
>>
>> Missing patch description. =A0Otherwise looks okay.
>
> This is a repeating complaint. Do I really need an extra =A0description
> for a trivial patch that does exactly what the Subject: says?

Fair enough.  I was going through your series pretty quickly and this
one doesn't really need it.

However, in this particular case, I think I would rather see both .dts
rework patches put into the same patch so it can be reviewed all at
once.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
