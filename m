Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id EAF97B7B6B
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Oct 2009 00:51:10 +1100 (EST)
Received: by ywh11 with SMTP id 11so1652666ywh.9
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Oct 2009 06:51:08 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091007091140.GC3177@pengutronix.de>
References: <1252594539-25202-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40909100805y4af7d85an602f501349a180f9@mail.gmail.com>
	<20091007091140.GC3177@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 7 Oct 2009 07:50:47 -0600
Message-ID: <fa686aa40910070650u78b5654eradfaa7d8a8e43745@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot/dts: drop obsolete 'fsl5200-clocking'
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 7, 2009 at 3:11 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Sep 10, 2009 at 09:05:46AM -0600, Grant Likely wrote:
>> On Thu, Sep 10, 2009 at 8:55 AM, Wolfram Sang <w.sang@pengutronix.de> wr=
ote:
>> > The 'fsl5200-clocking'-property was dropped since
>> > 0d1cde235874b00905bce23f659690d060ebf475. Remove all occurences in dts=
-files.
>> >
>> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>> > Cc: Grant Likely <grant.likely@secretlab.ca>
>>
>> Looks good to me. =A0I'll pick it up.
>
> Ping? :)

Haven't forgotten about it, but got nailed by start of school year and
conferences.  Its just a .dts change, so I have no problem merging
even though the merge window is closed.  It will be in 2.6.32.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
