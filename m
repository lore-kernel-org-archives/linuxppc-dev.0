Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B9B7DDFF8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jun 2007 05:10:18 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Htq2J-0002my-Mc
	for linuxppc-embedded@ozlabs.org; Thu, 31 May 2007 12:10:15 -0700
Message-ID: <10900170.post@talk.nabble.com>
Date: Thu, 31 May 2007 12:10:15 -0700 (PDT)
From: bert_maxel <bonlutin@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Audio Dirver for the 403/405?
In-Reply-To: <fa686aa40705301610q6ba8f2abq482f43a89f44d1bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10883262.post@talk.nabble.com>
	<fa686aa40705301610q6ba8f2abq482f43a89f44d1bc@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




Grant Likely-2 wrote:
> 
> On 5/30/07, bert_maxel <bonlutin@hotmail.com> wrote:
>>
>> Hi all,
>>
>> Has anybody got some working audio driver (linux) for the  ML403/405 ?
>> I know it's an ac97 codec, but I can't find anything related to the
>> xilinx
>> boards?
>> If nobody has worked on this yet, I'm in trouble. I don't know where to
>> start, or from what ac97 driver should I base my initial development?
> 
> IIRC, the old mvista 2.4 tree has an audio driver.
> 
> g.
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

There are plenty of boards with an ac97 codec, but what's missing is the
glue for the ML403 board, there's no pci bus in this case,  opb cores
instead.
I hope somebody can point me to a link of interest.

thanks
-- 
View this message in context: http://www.nabble.com/Audio-Dirver-for-the-403-405--tf3843165.html#a10900170
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
