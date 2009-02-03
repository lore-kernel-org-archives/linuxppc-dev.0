Return-Path: <gjb@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99138DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 19:04:21 +1100 (EST)
Message-ID: <4987FA9F.8060105@semihalf.com>
Date: Tue, 03 Feb 2009 09:04:47 +0100
From: Grzegorz Bernacki <gjb@semihalf.com>
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
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>, tech-denx@semihalf.com,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	linuxppc-dev@ozlabs.org
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
>> Dear Grzegorz Bernacki,
>>
>> In message <49872268.10003@semihalf.com> you wrote:
>>>> We also had this kind of problem - after feeding some nfs options it
>>>> worked :
>>>>
>>>> rsize=8192,wsize=8192,soft,intr,tcp,nolock
>>> it seems that it helps.
>> Can you please find out which of these changes is the relevant part?
> 
> Probably the ",tcp" bit
> 
> g.
> 
Yes, it's 'tcp'

Grzesiek
