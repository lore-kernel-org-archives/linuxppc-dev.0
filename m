Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id 4F86D2BE83
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Dec 2004 02:06:05 +1100 (EST)
Message-ID: <005201c4da13$2807f360$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: =?ISO-8859-15?Q?Bora_=DEahin?= <bora.sahin@ttnet.net.tr>,
	<linuxppc-embedded@ozlabs.org>
References: <065ACD8E84315E4394C835E398C8D5EBBBED0A@COSSMGMBX02.email.corp.tld>
	<8316506505.20041204160411@ttnet.net.tr>
Date: Sat, 4 Dec 2004 10:08:42 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-15"
Subject: Re: (Very) Simple question(s) compared to group topics
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If you go by MIPS, it takes very approximately 1000MIPS to decode DVD
quality MPEG2.
I don't think floating point helps with MPEG2, not sure about MPEG4.  You
also have to
think about memory bandwidth with an application like video.  All settop box
designs that
I'm aware of have some kind of MPEG decode coprocessor, either a separate
chip or built
into the main processor (like ATI Xilleon).

Mark Chambers
wvcomputronics.com

----- Original Message ----- 
From: "Bora Þahin" <bora.sahin@ttnet.net.tr>
To: <linuxppc-embedded@ozlabs.org>
Sent: Saturday, December 04, 2004 9:04 AM
Subject: (Very) Simple question(s) compared to group topics


> Hi,
>
>   I was subscribed to list a few days ago. I dont know this group is
eligible for my very simple or
>   basic questions compared to list topics. In one side asm codes is
discussed like one jump command
>   why not reach to symbol and the other side interrupt handling routines
is discussed like whether
>   or not critical interrupt handling is used in 405 EP. Subsequently, my
simple question is to stay
>   very basic. However if i get an answer(s) or redirections to correct
places, I can be very
>   grateful.
>
>   A bit summary about me...
>
>   So far, let say until the last one week or a bit over, I havent done any
work out of x86 including
>   any RISC cpu. I know inner workings of x86(asm) like segmentation,
paging, booting etc. not to be
>   very detailed. Before, I have dealt with mem. mag. especially in the
means of mm initialization,
>   booting, ...etc on the x86 imp. of the Linux kernel.
>
>   The subject...
>
>   PPC and 4xx series of it is absolutely new to me. We think to decode
"mpeg 4/level 5" coded films
>   on the 4xx series of ppc if it is possible. I examined a bit these cpus.
4xx series go to 700/800
>   MHZ clock freq but most of them dont contain floating point unit.(Only
one of them has fpu if my
>   memory dont serve me. I cant say it is connected. If i understand the
doc correctly, you can
>   connect a fpu to the system) This is just a point. I know clock freq is
not alone on the cpu
>   performance. I would like to hear experianced users testimonals or
thought about decoding of mpeg
>   performance of these cpus...
>
> -- 
> Bora Sahin
> borasahin.port5.com
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
