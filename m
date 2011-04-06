Return-Path: <sa212+lppc@cyconix.com>
Received: from smarthost03.mail.zen.net.uk (smarthost03.mail.zen.net.uk
	[212.23.3.142]) by ozlabs.org (Postfix) with ESMTP id 45790B6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 23:01:17 +1000 (EST)
Message-ID: <4D9C6413.8030103@cyconix.com>
Date: Wed, 06 Apr 2011 14:01:07 +0100
From: Evan Lavelle <sa212+lppc@cyconix.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: halt/reset on assert?
References: <4D966C5C.9030409__15236.8285613649$1301704900$gmane$org@cyconix.com>
	<m2sju1uoti.fsf@igel.home>
In-Reply-To: <m2sju1uoti.fsf@igel.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andreas -

that's great; thanks. I'm on 2.4.4, which doesn't have BUG_ON. The right 
way for 2.4.4 turns out to be

#define MY_ASSERT(expr) if(!(expr)) BUG()

-Evan
