Return-Path: <diggskevin38@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A355CB6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 03:04:19 +1000 (EST)
Received: by pzk26 with SMTP id 26so1037800pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Apr 2011 10:04:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302162933.2458.33.camel@pasglop>
References: <4D966C5C.9030409__15236.8285613649$1301704900$gmane$org@cyconix.com>
	<m2sju1uoti.fsf@igel.home> <4D9C6413.8030103@cyconix.com>
	<1302162933.2458.33.camel@pasglop>
Date: Thu, 7 Apr 2011 12:04:16 -0500
Message-ID: <BANLkTimX==Ei2Sn=86svSajHNX+0G1WM9w@mail.gmail.com>
Subject: Re: halt/reset on assert?
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
	Evan Lavelle <sa212+lppc@cyconix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 7, 2011 at 2:55 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2011-04-06 at 14:01 +0100, Evan Lavelle wrote:
>> #define MY_ASSERT(expr) if(!(expr)) BUG()
>
> Make it
>
> #define MY_ASSERT(expr) do { if .... } while(0)
>
> To ensure it has proper single statement semantics in C.
>
So THAT'S why they do this!!!!!! Now I just have to figure out what
'proper single statement semantics' means!

THANKS!!!

kevin

> Cheers,
> Ben.
