Return-Path: <mh@omnisys.se>
Received: from mail.omnisys.se (static-213-115-84-26.sme.bredbandsbolaget.se
	[213.115.84.26]) by ozlabs.org (Postfix) with ESMTP id 97CB067B9B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Nov 2006 02:34:28 +1100 (EST)
Message-ID: <456C4FBE.7040302@omnisys.se>
Date: Tue, 28 Nov 2006 16:03:26 +0100
From: Magnus Hjorth <mh@omnisys.se>
MIME-Version: 1.0
To: Peter Mendham <petermendham@computing.dundee.ac.uk>
Subject: Re: RE : Using Linux on ML405: Some basic questions
References: <000001c712c4$8252e870$c900a8c0@CRESITTLAB>
	<456C14F0.5020103@computing.dundee.ac.uk>
In-Reply-To: <456C14F0.5020103@computing.dundee.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Those messages come from the Linux bootloader/decompression code, you 
can see the calls in arch/ppc/boot/simple/misc-embedded.c

Cheers,
/Magnus


Peter Mendham wrote:
>
> Wow.  Thanks Chris, that makes a lot of sense, although I had no idea 
> that the SystemAce chip was quite so clever.  I take it that the 
> bitstream in the .ace file is specially constructed by the tools to do 
> the DRAM download?  What is it that produces the text:
> loaded at:     00400000 004E21E4
> board data at: 004DF13C 004DF154
> relocated to:  00405660 00405678
> zimage at:     00405C25 004DE92F
> avail ram:     004E3000 04000000
> I have always assumed that it is a piece of software that does this.  Is 
> that correct?
>
> Thanks very much for replying, the information is really helpful.
> -- Peter
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 

Magnus Hjorth, M.Sc.
Omnisys Instruments AB
Gruvgatan 8
SE-421 30  Västra Frölunda, SWEDEN
Phone: +46 31 734 34 09
Fax: +46 31 734 34 29
http://www.omnisys.se 
