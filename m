Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DB90DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jun 2007 06:38:42 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1HuDtJ-0005ZI-R0
	for linuxppc-embedded@ozlabs.org; Fri, 01 Jun 2007 13:38:33 -0700
Message-ID: <10920136.post@talk.nabble.com>
Date: Fri, 1 Jun 2007 13:38:33 -0700 (PDT)
From: bert_maxel <bonlutin@hotmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Audio Dirver for the 403/405?
In-Reply-To: <20070531193717.5743A1A48046@mail177-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <10883262.post@talk.nabble.com>
	<fa686aa40705301610q6ba8f2abq482f43a89f44d1bc@mail.gmail.com>
	<10900170.post@talk.nabble.com>
	<20070531193717.5743A1A48046@mail177-sin.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks for your input. 
Can you send me the dsp driver that goes with opb_ac97?
That'll be a good start for me, I appreciate your help.

thank you  Steve

bert

Stephen Neuendorffer wrote:
> 
> 
> There is an opb core developed for the Xilinx University Program board,
> which
> has a similar hardware interface to the ML403 (i.e. no PCI bridge)
> The XUPV2P web page with the opb_ac97 core is here:
> http://www.xilinx.com/univ/xupv2p.html 
> 
> I have a /dev/dsp driver (which I'll send to Bert directly) which limps
> along in 2.6.
> This core has a relatively small buffer and no master access to memory,
> which
> results in relatively poor performance, but it is a starting point.
> 
> Steve
> 
>> -----Original Message-----
>> From: 
>> linuxppc-embedded-bounces+stephen=neuendorffer.name@ozlabs.org
>>  
>> [mailto:linuxppc-embedded-bounces+stephen=neuendorffer.name@oz
> labs.org] On Behalf Of bert_maxel
>> Sent: Thursday, May 31, 2007 12:10 PM
>> To: linuxppc-embedded@ozlabs.org
>> Subject: Re: Audio Dirver for the 403/405?
>> 
>> 
>> 
>> 
>> Grant Likely-2 wrote:
>> > 
>> > On 5/30/07, bert_maxel <bonlutin@hotmail.com> wrote:
>> >>
>> >> Hi all,
>> >>
>> >> Has anybody got some working audio driver (linux) for the  
>> ML403/405 ?
>> >> I know it's an ac97 codec, but I can't find anything 
>> related to the 
>> >> xilinx boards?
>> >> If nobody has worked on this yet, I'm in trouble. I don't 
>> know where 
>> >> to start, or from what ac97 driver should I base my 
>> initial development?
>> > 
>> > IIRC, the old mvista 2.4 tree has an audio driver.
>> > 
>> > g.
>> > 
>> > --
>> > Grant Likely, B.Sc., P.Eng.
>> > Secret Lab Technologies Ltd.
>> > grant.likely@secretlab.ca
>> > (403) 399-0195
>> > _______________________________________________
>> > Linuxppc-embedded mailing list
>> > Linuxppc-embedded@ozlabs.org
>> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> > 
>> > 
>> 
>> There are plenty of boards with an ac97 codec, but what's 
>> missing is the glue for the ML403 board, there's no pci bus 
>> in this case,  opb cores instead.
>> I hope somebody can point me to a link of interest.
>> 
>> thanks
>> --
>> View this message in context: 
>> http://www.nabble.com/Audio-Dirver-for-the-403-405--tf3843165.
> html#a10900170
>> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>> 
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>> 
>> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Audio-Dirver-for-the-403-405--tf3843165.html#a10920136
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
