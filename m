Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp10.mail.mci.yahoo.co.jp (ybbsmtp10.mail.mci.yahoo.co.jp
	[210.80.241.184]) by ozlabs.org (Postfix) with SMTP id 7CA0667A76
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 10:36:23 +1100 (EST)
Message-ID: <421D1375.5000904@ybb.ne.jp>
Date: Thu, 24 Feb 2005 08:36:21 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Takeharu KATO <takeharu1219@ybb.ne.jp>
References: <421CD2B3.4020805@ybb.ne.jp>
	<421CD669.1040002@ybb.ne.jp>	<20050223142720.C13087@cox.net>
	<421D1085.5080602@ybb.ne.jp>
In-Reply-To: <421D1085.5080602@ybb.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC4xx Watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

>> Are you looking for the old "ppc405 watchdog" driver that simply
>> hooked into the generic PPC heartbeat facility? Or are you looking
>> for a driver that utilizes the 4xx/booke hardware watchdog facility?
>>
> I am looking for a driver that utilizes the 4xx/booke hardware watchdog 
> facility.
> 
> 
FYI, I wrote a driver uses 4xx/booke hardware watchdog.
BTW, is hooking PPC heartbeat facility obsoleted?

-- 
Takeharu KATO
