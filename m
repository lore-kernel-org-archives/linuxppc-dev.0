Return-Path: <joern@lazybastard.org>
Received: from longford.lazybastard.org (lazybastard.de [212.112.238.170])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0C51DE281
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 03:44:27 +1100 (EST)
Date: Tue, 30 Oct 2007 16:33:10 +0100
From: =?utf-8?B?SsO2cm4=?= Engel <joern@logfs.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 0/3] Add device-tree aware NDFC driver
Message-ID: <20071030153310.GB13455@lazybastard.org>
References: <20071029201738.GA2022@ru.mvista.com>
	<alpine.LFD.0.9999.0710300235580.3186@localhost.localdomain>
	<47273BF4.80001@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <47273BF4.80001@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>, sr@denx.de,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 30 October 2007 17:13:08 +0300, Valentine Barshak wrote:
> 
> I'm not saying my approach is the best, but I was hoping for a discussion.

That is good.  So please take a moment to listen.

> I've reworked the patches according to the comments to the previous 
> version and used my arguments to explain why I don't see much reason to 
> mess with the code we currently have and added a separate _of version.

Ok.

> This is the last time I disturb you with my e-mail, so please, forget it.

Thomas words were harsh.  Nothing unusual so far.  Some people deserve
harsh words, some don't and some simply are doing a good job to invite
them.  You mails so far were inviting harsh words.

So how did you invite harsh words and what can you change to prevent
this in the future?

1. Develop a thicker skin.  No matter how well you do, there will always
be the occasional harsh words, deserved or not.  It is ok to get angry
and call the person names - but do that at home and leave it out of your
responses.  Ignore the flamebait, at least in public.

2. Follow local customs.  In particular you should follow the style of
discussion commonly used in mailing lists:

	>>> I'm doing this.
	>> Crap! Never do that!
	> Why not?  Can you explain?
	Because...

	>>> Then I do that.
	>> Wouldn't ABCD be better?
	> ABCD wouldn't work for me because of XYZ.
	Fair enough.

Respond to individual comments _directly_following_the_comment_ do not
collect comments from 10 mails, then respond to them all in a long
paragraph.  Noone will read that.  I didn't read it either.

3. Be concise.  When quoting someone, remove everything but the relevant
bits.  Respond only with relevant information.  People regularly read
10+ mailing lists.  Their attention span is short.  If you manage to
annoy them with irrelevant information in the first 10 lines, they will
skip any amount of wisdom below.

4. Be polite.  Even if the responses you get are not.  Flamewars get you
nowhere.

5. Have sound technical arguments.  "mtd concat adds a slight overhead"
is not for two reasons.  First, it is lacking numbers.  People's guesses
about perceived overhead or usually wrong, so knowledgeable readers will
immediately question such arguments.  Secondly, you didn't explain _why_
mtdconcat adds overhead.  In particular, why didn't you reduce the
mtdconcat overhead instead of essentially copying its functionality?

6. Be structured.  Empty lines are cheap.  Use them.  Add structure to
your mails.  Above you can see several paragraphs.  You can quickly go
back to a previous one.  You can skip one after reading just the first
sentence.  After several attempts I still haven't read your 46-line
monologue.  I don't even know how far I made it because it is so damn
hard to find the spot again.


If you are willing to change the style of your mails, maybe people will
actually read them and respond to you in ways you expected.  Otherwise
it may indeed be a wise choice not to come back.  Some people simply
just don't get along.  Sometimes a proxy is needed to translate between
people.  But my hope is that you are willing and able to work with us
directly.

Jörn

-- 
There is no worse hell than that provided by the regrets
for wasted opportunities.
-- Andre-Louis Moreau in Scarabouche
