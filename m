Message-ID: <412B0020.70805@246tNt.com>
Date: Tue, 24 Aug 2004 10:45:20 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Gabor Janak <g.janak@unicontrol.de>,
	linuxppc-embedded@lists.linuxppc.org, Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] Re: BestComm and fec
References: <412A4B69.7000305@246tNt.com> <149461203.20040824120707@varma-el.com>
In-Reply-To: <149461203.20040824120707@varma-el.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

>>Apparently, you've both worked out a version of bestcomm for 2.6. But
>>you both based it on old code. (even non GPL).
>>
>>
>
>Terrible, may be its time to create special project for MPC5200 (if it
>doesn't exist in somewhere in I-net)? First intention - sourceforge.
>Comments/suggestions?
>
>Sylvain, Wolfgang I know you already have projects. But in case of
>Sylvain, as I understand, his project on his homepage.
>In case of Wolfgang, I'm not sure that DENX will happy to share their
>internal CVS with all I-net for write access. Am I right?
>
>
I personnaly use BitKeeper to maintain my trees. I can't provide write
access to them because I don't administrate the server they are on,
To write, you would need a ssh account and I juste have one for me and
can't create others.

I try to publish what I'm doing in www.246tNt.com/mpc52xx/state.txt

>>I've just tried just taking the newer one and stick it in 2.6 with the
>>fec Gabor sent, but it just crashes so it need more work ;) Dale
>>Farnsworth just said it'll look into it and porting new bestcomm as well.
>>
>>
>
>My fec port work ok.
>
>
Based on old bestcomm or new ?

>And CAN, RTC, and possible CRC32/16 (if it will fast enough) :).
>
>
CAN is not on my personnal project list since I have nothing that uses
so I couldn't test it anyway.

RTC ? The MPC5200 can't save time AFAIK. And Linux should already
'count' time correctly I think.

By CRC32/16 I guess you mean to use the BestComm DMA engine to implement
the kernel CRC Library ? I'm not sure


I've pushed PCI on my tree ( bk://bkbits.246tNt.com/linux-2.5-mpc52xx )
yesterday night. So if you're in position to test it please report ;)



Sylvain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
