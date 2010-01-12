Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id C4201B7BEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jan 2010 01:31:00 +1100 (EST)
Received: by yxe9 with SMTP id 9so11619320yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 06:30:59 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <201001120855.59122.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<200912220800.54373.roman.fietze@telemotive.de>
	<fa686aa41001111121u5c943fc7p789c0ec0b41af883@mail.gmail.com>
	<201001120855.59122.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 Jan 2010 07:29:04 -0700
Message-ID: <fa686aa41001120629k36484ce7l806d67fe79304d42@mail.gmail.com>
Subject: Re: [PATCH 03/13] mpc52xx: add SCLPC register bit definitions
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

On Tue, Jan 12, 2010 at 12:55 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
> On Monday 11 January 2010 20:21:22 Grant Likely wrote:
>> Why is the list head being removed?
>
> Not used at all, except in initialization?
>
> Of course a seperate patch would have been needed.

For the record, I put the list_head in when writing the driver so that
requests can get queued up instead of the one-at-a-time model
currently used.  It is still my intention to implement request queuing
but as with so many things I haven't got to it yet.  :-/

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
