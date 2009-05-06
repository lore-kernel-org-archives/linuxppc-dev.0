Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 3C0D3DE34E
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:41:51 +1000 (EST)
Received: by gxk20 with SMTP id 20so787545gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 15:41:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090506220225.A013583420E8@gemini.denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-2-git-send-email-wd@denx.de>
	<fa686aa40905061335q3a3c4cc7r33d77df655100531@mail.gmail.com>
	<20090506220225.A013583420E8@gemini.denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 16:41:30 -0600
Message-ID: <fa686aa40905061541v6ff7777dl81f2f7116f26b0e2@mail.gmail.com>
Subject: Re: [PATCH 01/12] fs_enet: Use defines to set driver tunables.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	Detlev Zundel <dzu@denx.de>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 4:02 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grant,
>
> In message <fa686aa40905061335q3a3c4cc7r33d77df655100531@mail.gmail.com> you wrote:
>> On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
>> > From: Piotr Ziecik <kosmo@semihalf.com>
>> >
>> > Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
>> > Signed-off-by: Wolfgang Denk <wd@denx.de>
>> > Cc: <netdev@vger.kernel.org>
>> > Cc: Grant Likely <grant.likely@secretlab.ca>
>> > Cc: John Rigby <jcrigby@gmail.com>
>>
>> Not seeing much benefit to this patch, and the (non-existant) patch
>> description doesn't really help me here either.
>
> Please see next patch which then uses the ability to change the
> defaults.

Please state that in the patch description when you repost it.  :-P

g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
