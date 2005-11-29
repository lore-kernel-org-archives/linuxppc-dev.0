Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 675BE68802
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 21:25:21 +1100 (EST)
Message-ID: <438C2C8E.6090701@ru.mvista.com>
Date: Tue, 29 Nov 2005 13:25:18 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: ihornberger@sysgo.com
References: <438B379B.6090904@ru.mvista.com>
	<1133258862.2664.13.camel@iho.sysgo.com>
In-Reply-To: <1133258862.2664.13.camel@iho.sysgo.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] ppc32: Adds MPC885ADS, MPC866ADS and	MPC8272ADS-specific
 platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ingo Hornberger wrote:
> Hi Vitaly,
> 
> OK, I don't really see the advantage of removing the identification
> stuff, but perhaps I'm missing something. Was there any discussion in
> the past that I've skipped while reading through the archive?
> 
> Because I found the identifcation code really nice. The only problem was
> that my 8xx didn't support the SVR register.
> 
There was a number of discussions in this regard, which result finally that there no method to identify 8xx board 
uniquely just using board registers. Hence, we are making identification by board name; the names are presented in syslib/mpc8xx_sys.c.
You can see example in this patch.

> regards,
> 	Ingo
> 
> On Mon, 2005-11-28 at 20:00 +0300, Vitaly Bordug wrote:
>> Added proper ppc_sys identification and fs_platform_info's for MPC 885ADS, 866ADS and 
>> 8272ADS. Assuming setbitsXX/clrbitsXX patch is applied.
>>
>>
>> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>>
>> ---
>> Sincerely,
>> Vitaly
>>
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 


-- 
Sincerely, 
Vitaly
