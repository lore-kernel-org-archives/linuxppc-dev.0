Return-Path: <geoffrey.levand@am.sony.com>
Received: from ns6.sony.co.jp (NS6.Sony.CO.JP [137.153.0.32])
	by ozlabs.org (Postfix) with ESMTP id 4286B67E61
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 11:11:20 +1100 (EST)
Received: from mail3.sony.co.jp (localhost [127.0.0.1])
	by mail3.sony.co.jp (R8/Sony) with ESMTP id kAE0BFbC008243
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 09:11:15 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail3.sony.co.jp (R8/Sony) with SMTP id kAE0BFl5008233
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 09:11:15 +0900 (JST)
Message-ID: <4559099A.6060805@am.sony.com>
Date: Mon, 13 Nov 2006 16:11:06 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com> <20061110152310.7419ef3e@pb15>
In-Reply-To: <20061110152310.7419ef3e@pb15>
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

Olof Johansson wrote:
> Hi,
> 
> Just a couple of small comments, I haven't had time to get deeper into
> the patchset yet. :-)
> 
> On Fri, 10 Nov 2006 12:02:19 -0800 Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> 
>> This adds the core platform support for the PS3 game console and other
>> platforms using the PS3 Platform hypervisor.
>> 
>> 
>> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>> 
>> ---
>>  MAINTAINERS                             |    7 
>>  arch/powerpc/Kconfig                    |   11 
>>  arch/powerpc/platforms/Makefile         |    1 
>>  arch/powerpc/platforms/ps3pf/Kconfig    |   32 +
> 
> Why are you naming the platform "platform" as in "this is the ps3pf
> platform" which expands to "this is the ps3 platform platform"? ps3 is
> quite adequate as the platform name. :-)

I had it as ps3, but I was told to change it to ps3pf.  I don't
like that name though.

-Geoff
