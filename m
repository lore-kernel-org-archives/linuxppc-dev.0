Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-06.bluehost.com (outbound-mail-06.bluehost.com
	[67.138.240.206]) by ozlabs.org (Postfix) with SMTP id 9319E68926
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 04:30:47 +1100 (EST)
Message-ID: <43CD29B4.5070607@secretlab.ca>
Date: Tue, 17 Jan 2006 10:30:28 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Peter Ryser <peter.ryser@xilinx.com>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
References: <20060114094658.GA12639@secretlab.ca>
	<43CC5453.3060702@xilinx.com> <43CC9F35.8010305@secretlab.ca>
	<43CCE89B.8050603@xilinx.com> <43CD1021.7080205@secretlab.ca>
	<43CD240C.2050907@xilinx.com>
In-Reply-To: <43CD240C.2050907@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrei Konovalov <akonovalov@mvista.com>, Grant Likely <grant@secretlab.ca>,
	Rick Moleres <Rick.Moleres@xilinx.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Ryser wrote:
> 
>> I don't understand what you mean.  It sounds like your suggesting I do 
>> exactly opposite what you're arguing; hand modify one of the 
>> xparameters_*.h files.  Are you saying that edk can't generate Linux 
>> redefines for the ml403 at the moment? 
> 
> 
> Yes, it can. It looks they are not present in the xparameters_ml403.h 
> that you submitted as part of your patch. I'll send you the 
> automatically generated file in a seperate email.

okay good; I misunderstood what you were saying.  I pulled 
xparameters_ml403.h out of the ref design w/ the standalone bsp.  I just 
haven't bothered trying to generating the Linux bsp yet.

> 
>> I do *not* think I should replace the edk-generated 
>> xparameters_ml403.h with a hacked xparameters_ml300.h file.  I'd 
>> rather use the generated _ml403 file and change the infrastructure 
>> when the Linux redefines are ready. 
> 
> 
> See above. BTW, I'm not sure how familiar you are with the process in 
> EDK. Let me know if I can help you step through it.

okay, I'll ping you when I've got questions.

>> I understand that it's not *recommended*; I'm just saying it's not 
>> always *reality*  :p 
> 
> 
> Yeah, that's true for user projects. However, I hope that we can get the 
> default included in the Linux 2.6 kernel right.

yes, definately

> 
>> Yes; but I already said that I'll change the patch to use the Xilinx 
>> redefines.  My argument is simply that *if* changes are required, 
>> there is a way for the user to do it.  In the normal (recommended) 
>> case; nothing will need to be done.  (think Larry Wall's quote: "easy 
>> things easy; hard things possible)
>>
>> When it is needed; the fixups will be in xparameters.h; not 
>> xparameters_*.h; and they'll be for a specific port.  The fixups will 
>> only need to be done once per project (most likely). 
> 
> 
> I'm not sure that I follow your argument here.

I'll compose my answer in code; watch for patches.  :)

btw, once Linus closes the 2.6.16 merge window, it looks like we may be 
able to use the powerpc.git tree for tracking these changes.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
