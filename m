Return-Path: <jirislaby@gmail.com>
Received: from mail-bw0-f223.google.com (mail-bw0-f223.google.com
	[209.85.218.223]) by ozlabs.org (Postfix) with ESMTP id B952C1007D2
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 19:47:07 +1100 (EST)
Received: by bwz23 with SMTP id 23so1542051bwz.9
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Nov 2009 00:47:04 -0800 (PST)
Message-ID: <4B10E385.1030900@gmail.com>
Date: Sat, 28 Nov 2009 09:47:01 +0100
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 16/27] PPC: use helpers for rlimits
References: <1259363167-9347-1-git-send-email-jslaby@suse.cz>	
	<1259363167-9347-16-git-send-email-jslaby@suse.cz>
	<1259367557.2076.11.camel@pasglop>
In-Reply-To: <1259367557.2076.11.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: sfr@canb.auug.org.au, nhorman@tuxdriver.com,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	linux-kernel@vger.kernel.org, oleg@redhat.com,
	linuxppc-dev@ozlabs.org, mingo@redhat.com, tglx@linutronix.de,
	marcin.slusarz@gmail.com, hpa@zytor.com,
	Paul Mackerras <paulus@samba.org>, akpm@linux-foundation.org,
	James Morris <jmorris@namei.org>, torvalds@linux-foundation.org,
	mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/28/2009 01:19 AM, Benjamin Herrenschmidt wrote:
> On Sat, 2009-11-28 at 00:05 +0100, Jiri Slaby wrote:
>> Make sure compiler won't do weird things with limits. E.g. fetching
>> them twice may return 2 different values after writable limits are
>> implemented.
>>
>> I.e. either use newly added rlimit helpers or ACCESS_ONCE if not
>> applicable.
> 
> Thanks. I have that already queued up.

Are you sure? The previous version with ACCESS_ONCE was generally
NACKed. This one uses a newly added helper which is much more cleaner
way to do it.

thanks,
-- 
js
