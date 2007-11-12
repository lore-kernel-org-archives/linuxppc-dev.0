Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id BA1F9DDE98
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 09:28:31 +1100 (EST)
Message-ID: <4738D380.8050209@semihalf.com>
Date: Mon, 12 Nov 2007 23:28:16 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v4 04/13] [POWERPC] Add generic support for simple MPC5200
	based boards
References: <20071110124327.1C46A248D3@gemini.denx.de>
In-Reply-To: <20071110124327.1C46A248D3@gemini.denx.de>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <20071109171202.16289.2618.stgit@hekate.izotz.org> you wrote:
>> This patch adds support for 'mpc5200-simple-platform' compatible
>> boards which do not need a platform specific setup. Such boards
>> are supported assuming the following:
> ...
>> +	const char *board[] = {	
>> +		"tqc,tqm5200",
>> +		"promess,motionpro",
>> +		"schindler,cm5200",
>> +		NULL
>> +	};
> 
> would it make sense to sort this list alphabetiacally? At the moment
> we can setill easily find each board, but assume that list grows to 50
> boards names...

Yes, that may be helpful, will change that.

Cheers,
Marian
