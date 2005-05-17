Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp05.mail.mci.yahoo.co.jp (ybbsmtp05.mail.mci.yahoo.co.jp
	[210.80.241.154]) by ozlabs.org (Postfix) with SMTP id 61220679F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 00:42:24 +1000 (EST)
Message-ID: <428A040D.40604@ybb.ne.jp>
Date: Tue, 17 May 2005 23:47:41 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
References: <42884448.6040505@ybb.ne.jp>	<63792af268f18c480d5ecf218a4e61af@freescale.com>
	<42898825.3000803@ybb.ne.jp>
In-Reply-To: <42898825.3000803@ybb.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] BOOKE_WDT Part 1/2 (Re: PPC 44x Watchdog timer)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar:

>> No problem, can you replace all the cmd line parsing with 
>> early_param() code in arch/ppc/kernel/setup.c.  Take a look at 
>> arch/ppc64/kernel/setup.c for an example.  We still need to add a call 
>> to parse_early_param() in setup_arch().
>>
> Sorry, I can not figure out what you want.
> As far as I look the source tree,arch/ppc/kernel/setup.c does not have 
> the function called early_param.
> Would you give me a more precise explanation?
> 
On second thought, I make sense what you said.
You asked me that I make some kind of cleanups, didn't you?
If it is true, I'll try to clean up these setups, but it may be
take the time.
