Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 59BE1DDF34
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 22:09:01 +1100 (EST)
Message-ID: <498825C8.3040406@matrix-vision.de>
Date: Tue, 03 Feb 2009 12:08:56 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add support for the digsy MTC board.
References: <1233329630876-git-send-email-gjb@semihalf.com>	
	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>	
	<4986EC33.9000600@semihalf.com>
	<49871C8C.8030200@matrix-vision.de>	 <49872268.10003@semihalf.com>	
	<20090202235811.AD8E78322908@gemini.denx.de>
	<fa686aa40902021605m3a694f40l77d90f2079ef2e83@mail.gmail.com>
In-Reply-To: <fa686aa40902021605m3a694f40l77d90f2079ef2e83@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tech-denx@semihalf.com, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Mon, Feb 2, 2009 at 4:58 PM, Wolfgang Denk <wd@denx.de> wrote:
>   
>> Dear Grzegorz Bernacki,
>>
>> In message <49872268.10003@semihalf.com> you wrote:
>>     
>>>> We also had this kind of problem - after feeding some nfs options it
>>>> worked :
>>>>
>>>> rsize=8192,wsize=8192,soft,intr,tcp,nolock
>>>>         
>>> it seems that it helps.
>>>       
>> Can you please find out which of these changes is the relevant part?
>>     
>
> Probably the ",tcp" bit
>
> g.
>
>   
yes - obviously the retry counter of lost udp packets is pretty small 
inside the nfs client or server.
The problem only occurs when there's fairly high traffic and/or low 
performance switches are used and UDP packets get lost frequently.

regards,
Andre

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
