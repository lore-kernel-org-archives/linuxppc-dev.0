Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id B47CFB6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 11:11:57 +1100 (EST)
Received: by yxe9 with SMTP id 9so5731402yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Dec 2009 16:11:56 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912171355.34694.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912151159.40628.roman.fietze@telemotive.de>
	<fa686aa40912151150o64f97533h1b736b4445301192@mail.gmail.com>
	<200912171355.34694.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 21 Dec 2009 17:11:30 -0700
Message-ID: <fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
Subject: Re: [PATCH] PowerPC: const intspec pointers
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 17, 2009 at 5:55 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> Hello Grant,
>
> On Tuesday 15 December 2009 20:50:05 Grant Likely wrote:
>
>> Yes, I'm using the driver in a couple of projects. =A0It works for me
>> for both RX and TX (although TX+DMA has been troublesome).
>
> That's what I found out.
>
>> The test driver on the other hand is pretty poor code. =A0Don't expect
>> much from it other than some hints. =A0There's a reason I didn't merge
>> that chunk.
>
> I brought it up to speed before using it.
>
>> Yes, please post the patches and cc: me. I'll review, test, and make
>> comments.
>
> I hope it's ok that I've copied them to my web space instead of
> providing patches in a mail. The URL is:
>
> =A0http://www.fietze-home.de/telemotive/linux-2.6-telemotive-mpc.git

"Access Forbidden!"

It is easier for me though if you post them to the list.  Then I can
just hit "reply to all" and make comments on the code.

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
