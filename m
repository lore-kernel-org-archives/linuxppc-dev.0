Return-Path: <nbarendt@vxitech.com>
Received: from vxitech.com (unknown [66.18.101.86])
	by ozlabs.org (Postfix) with ESMTP id D17E867C38
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jul 2005 03:58:31 +1000 (EST)
Message-ID: <42D2AF46.9000200@vxitech.com>
Date: Mon, 11 Jul 2005 13:41:26 -0400
From: Nick Barendt <nbarendt@vxitech.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20050711113948.vznzvgxu15nkkwcg@webmail.ellipticity.com>
	<6.2.3.4.1.20050711112652.02b82cc8@mail.int.acdstar.com>
In-Reply-To: <6.2.3.4.1.20050711112652.02b82cc8@mail.int.acdstar.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: MPC5200 Rev. B
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eric N. Johnson (ACD) wrote:

> mgberry@ellipticity.com wrote:
>
>> Has anyone experienced any issues with the Rev. B silicon for the 
>> MPC5200.  We are seeing Linux hanging and are suspecting the SDRAM 
>> errata for Rev. B.  If we disable the cache this seems to improve but 
>> will still crash over time in heavy loads.  We have not seen any of 
>> these type issues with the original rev.
>
>
> Are you sure you have revision B of the MPC5200?  Freescale has 
> announced a "B" version, but I don't believe that any of them have hit 
> the public yet.  There may be some engineering grade samples out 
> there. (Let me know if you really do have "B" parts.  Freescale has 
> been telling me "real soon now" since last year)


I can confirm that there are engineering samples of at least the first 
mask set of the Rev. B part floating around.  A friend sent me one:

 PPC5200CVR400 mask set M08A. 

Our local rep has hemming and hawing, too, which is getting very 
frustrating, knowing that other developers have had silicon in there 
hands for some time, and that several of the errata on the L25R mask set 
(PCI DMA arbitration, among them) have been causing us some serious 
headaches.

We have had very limited success with the Rev B engineering part, 
populated on a custom board.  Basically locking up at boot time when the 
DDR is enabled.  We're trying to isolate the problem to a hardware 
(board/part damaged) or software (are there changes to the memory 
controller configuration required for the Rev. B?). 

We do know that there are still errata on the first mask rev and that a 
second mask rev is in process.

Anyone else have anything to report?

-Nick
