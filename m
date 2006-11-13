Return-Path: <geoffrey.levand@am.sony.com>
Received: from ns8.sony.co.jp (NS8.Sony.CO.JP [137.153.0.33])
	by ozlabs.org (Postfix) with ESMTP id 71A9267E47
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:52:34 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAD3qVbC028170
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 12:52:31 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAD3qVl5028156
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 12:52:31 +0900 (JST)
Message-ID: <4557EBF8.2010207@am.sony.com>
Date: Sun, 12 Nov 2006 19:52:24 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/16] powerpc: add ps3 platform hvcalls
References: <4554DAD7.2090709@am.sony.com> <200611110313.40940.arnd@arndb.de>
In-Reply-To: <200611110313.40940.arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Friday 10 November 2006 21:02, Geoff Levand wrote:
>> Adds the ps3pf hvcalls.
>> 
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> This one reminds of the inline hcall abstraction layer I did
> some time ago. The implementation in your patch is a lot
> less elegant than both the pseries in its current incarnation
> and the one that I did (IMHO). Any opinions on how we should
> proceed here?


I wanted to do some cleanup here, but Ben suggested to wait until
this was released publicly.  

I would like to have full function declarations that would be ctags
parable, and inline docs of all the lv1 call arguments.  With the
current implementation there is no way to understand many of the
arguments.  Another is to preserve the inline wrapper, or have some
other mechanism that allows call instrumentation.  This is old code
done by someone else, I have no affection for it.


> I can dig out my patch again in the version I did for the
> ps3 hypervisor, if there is demand, or I could help moving
> over so code that is more like the pseries one. Unfortunately
> the calling conventions are very different from pseries 
> (the hcall number is passed in r11, not in one of the argument
> registers), so that would not be as nice as Anton's implementation.


If you have something, I would like to see it.

-Geoff
