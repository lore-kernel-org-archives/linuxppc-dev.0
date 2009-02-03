Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.189])
	by ozlabs.org (Postfix) with ESMTP id 4CDDBDDEE1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 11:05:53 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j67so1294811rne.16
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Feb 2009 16:05:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090202235811.AD8E78322908@gemini.denx.de>
References: <1233329630876-git-send-email-gjb@semihalf.com>
	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
	<4986EC33.9000600@semihalf.com> <49871C8C.8030200@matrix-vision.de>
	<49872268.10003@semihalf.com>
	<20090202235811.AD8E78322908@gemini.denx.de>
Date: Mon, 2 Feb 2009 17:05:51 -0700
Message-ID: <fa686aa40902021605m3a694f40l77d90f2079ef2e83@mail.gmail.com>
Subject: Re: [PATCH] Add support for the digsy MTC board.
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, tech-denx@semihalf.com,
	Detlev Zundel <dzu@denx.de>, Andre Schwarz <andre.schwarz@matrix-vision.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 2, 2009 at 4:58 PM, Wolfgang Denk <wd@denx.de> wrote:
> Dear Grzegorz Bernacki,
>
> In message <49872268.10003@semihalf.com> you wrote:
>>
>> > We also had this kind of problem - after feeding some nfs options it
>> > worked :
>> >
>> > rsize=8192,wsize=8192,soft,intr,tcp,nolock
>>
>> it seems that it helps.
>
> Can you please find out which of these changes is the relevant part?

Probably the ",tcp" bit

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
