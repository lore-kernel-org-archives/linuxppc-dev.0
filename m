Return-Path: <antonio.dibacco@aruba.it>
Received: from mx1.aruba.it (mxaruba.aruba.it [62.149.128.10])
	by ozlabs.org (Postfix) with SMTP id A1852679F4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 02:49:09 +1100 (EST)
Message-ID: <20060307154903.18326.qmail@mx1.aruba.it>
References: <20060307131500.3467.qmail@mx1.aruba.it>
	<20060307165522.7936fd7b@vitb.ru.mvista.com>
	<20060307153716.1130.qmail@mx1.aruba.it>
	<20060307184217.1422472c@vitb.ru.mvista.com>
In-Reply-To: <20060307184217.1422472c@vitb.ru.mvista.com> 
From: "antonio.dibacco" <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: fs_enet on 2.4 and 8xx_immap
Date: Tue, 07 Mar 2006 15:49:03 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm a novice and I don't understand what is "IIRC". Is something that 
handles the two FECs on 885ads? I knew that on 885ads the second ethernet 
was realized via an SCC and not FEC. Am I wrong? 

Bye,
Antonio. 


Vitaly Bordug Scrive: 

> On Tue, 07 Mar 2006 15:37:16 GMT
> "antonio.dibacco" <antonio.dibacco@aruba.it> wrote: 
> 
>> I think I will use the 8xx_immap.h borrowed from u-boot-1.1.4, it is really 
>> similar to that of 2.4.25, with some explicit padding and fec2. Do you think 
>> that porting fs_enet to 2.4 is it the best way to have both FECs working on 
>> a MPC875? I don't want to use 2.6. 
>> 
> Sounds reasonable, but I'll repeat:
> fs_enet patches for 2.6 used to support 2.4 thing(via #ifdef's), it was cleaned up close to submission. IIRC, it handles 2 fecs quite great on my 885ads, so it worths to search around a bit before hacking... 
> 
>> Bye,
>> Antonio.  
>> 
>> Vitaly Bordug Scrive:  
>> 
>> > On Tue, 07 Mar 2006 13:15:00 GMT
>> > "antonio.dibacco" <antonio.dibacco@aruba.it> wrote: 
>> > 
>> >> I think that to make it work I need to update cpm8xx_t inserting the fec2 
>> >> filed. Is this true? Could I use the 8xx_immap.h of a 2.6 kernel? 
>> >> 
>> > Not exactly. I think you can borrow the structures from 2.6, but do a triple-check that the result offsets are the same. 
>> > 
>> >> Bye,
>> >> Antonio.
>> >> _______________________________________________
>> >> Linuxppc-embedded mailing list
>> >> Linuxppc-embedded@ozlabs.org
>> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded 
>> >> 
>> >> 
>> >  
>> > 
>> > -- 
>> > Sincerely, 
>> > Vitaly
>>   
>> 
>> 
>  
> 
> -- 
> Sincerely, 
> Vitaly
 
