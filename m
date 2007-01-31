Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CAC49DDFB8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 17:46:50 +1100 (EST)
In-Reply-To: <266006.37029.qm@web8410.mail.in.yahoo.com>
References: <266006.37029.qm@web8410.mail.in.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <42D831B8-9452-48E1-B996-2E970EB9DC27@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Differentiate between two e500 core (in mult-core e500)
Date: Wed, 31 Jan 2007 00:45:50 -0600
To: vinay hegde <thisismevinay@yahoo.co.in>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 30, 2007, at 10:58 PM, vinay hegde wrote:

> Hi,
>
> Sorry for the repeat mail on this, I forgot to ask the
> question;-)
>
> If anybody knows how to differentiate one e500 core
> from another (in multi-core proc's), please post a
> message.

Do you mean some software ID to know which core you are running on?

If so the PIR should be used for this purpose.

- k

> --- vinay hegde <thisismevinay@yahoo.co.in> wrote:
>
>> Hi,
>>
>> I have a need to write a POST sort of a test to test
>> L1 data/inst cache residing on each of the e500 v2
>> multi-core seperately (for a network hardware). This
>> is because multicore e500 has seperate L1 caches and
>> shared L2 cache.
>>
>> This is for mpc8572. I learnt from this list that
>> mpc8572 isn't out yet, but thought that
>> differentiating between e500 mult-cores has nothing
>> to
>> do with mpc8572.
>>
>> Please let me know if you have any inputs.
>>
>> Thanks,
>> Vinay.
>>
>>
>>
>>
> ______________________________________________________________________ 
> ______________
>> Expecting? Get great news right away with email
>> Auto-Check.
>> Try the Yahoo! Mail Beta.
>>
> http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>>
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>
>
>
>
> ______________________________________________________________________ 
> ______________
> Don't get soaked.  Take a quick peak at the forecast
> with the Yahoo! Search weather shortcut.
> http://tools.search.yahoo.com/shortcuts/#loc_weather
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
