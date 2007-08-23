Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8325BDDE3C
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 09:38:45 +1000 (EST)
Date: Thu, 23 Aug 2007 18:17:29 -0500 (CDT)
Message-Id: <200708232317.l7NNHTjq011892@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Stephen Rothwell                    <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] [POWERPC] Remove cmd_line from head*.S
In-Reply-To: <1A23DF12-65EB-4236-B78A-ADF1DDF0FFFD@kernel.crashing.org>
References: <1A23DF12-65EB-4236-B78A-ADF1DDF0FFFD@kernel.crashing.org>,
	<20070823130913.2e9db6eb.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu Aug 23 13:27:31 EST 2007, Kumar Gala wrote:
> On Aug 22, 2007, at 10:09 PM, Stephen Rothwell wrote:
>>
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 0028fe6..dc85005 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -60,6 +60,8 @@
>>  #endif
>>
>>
>> +char cmd_line[COMMAND_LINE_SIZE];
>> +
>
> would this be better in setup-common.c?
>


I strongly agree with Kumar.  It doesn't belong in prom.c

milton
