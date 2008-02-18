Return-Path: <alohanono@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id F13E7DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 02:09:37 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1189619fgg.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Feb 2008 07:09:35 -0800 (PST)
Message-ID: <47B99FAC.3050709@gmail.com>
Date: Mon, 18 Feb 2008 16:09:32 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: APU FPU in Virtex ppc405
References: <47ACA4BB.6010903@gmail.com>	<fa686aa40802081132h22b91464xd150e0671ca4fc34@mail.gmail.com>	<47B02CB0.8040002@gmail.com>
	<loom.20080217T072721-349@post.gmane.org>
In-Reply-To: <loom.20080217T072721-349@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Thomas,

 I am still very interested in this. It would be really good if you can 
post what you have so far. Did you also have to patch gcc also? Is there 
any penalty in performance when compiling with -fshort-double?

 /Albert

Thomas Werne wrote:
> A. Nolson <alohanono <at> gmail.com> writes:
>
>   
>> I have been checking and it seems that the APU FPU patches will give 
>> some headaches now, so I will probably wait until they merge them with 
>> the official GCC release. In any case, it seems that the FPU restricts 
>> the PowerPC and bus frequencies to a max of 200/100.
>>
>> Anyway, thanks for the info. I will try to keep track of this in case of 
>> an update.
>>
>>     
>
> Hi -
>
> You can get the FPU to work with the 2.6.24rc3 Linux (I got it to work just
> yesterday).  There are a couple of small changes you have to make to kernel
> config files and to one of the .h files, plus you need to compile with the
> -fshort-double flag to convert all doubles into floats.  Let me know if you're
> still interested and I can post details and/or patches.
>
> Thomas
>
> --
> Thomas Werne
> NASA Jet Propulsion Laboratory
>
> All personal and professional opinions presented herein are my
> own and do not, in any way, represent the opinion or policy of JPL.
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
