Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-27.bluehost.com (outbound-mail-27.bluehost.com
	[67.138.240.193]) by ozlabs.org (Postfix) with SMTP id DF18F6891F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jan 2006 19:25:16 +1100 (EST)
Message-ID: <43BA34C5.9050609@secretlab.ca>
Date: Tue, 03 Jan 2006 01:24:37 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Paula_Saame=F1o?= <gnathita@gmail.com>
References: <259581790601030012u1ec195c2n7f42766d443548c2@mail.gmail.com>
In-Reply-To: <259581790601030012u1ec195c2n7f42766d443548c2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 8/8] Add support for Xilinx ML403 reference design
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Paula Saameño wrote:
> I am working with ML403 as well. Right now, I am using a 2.4.26 kernel,
> but I would be interested in a 2.6 one, it would be great!!
> 
> Happy 2006!!
> Paula Saameno

Thanks Paula.

Can you try the posted patches on your ML403?  It should compile and
boot with no problems with the reference design.  (However, I got the
memory size initialization wrong; add mem=64M to the kernel command line)

I'll send a patch to fix the mem size tomorrow.

Thanks,
g.

> 
> Florian wrote:
>>> I don't have a public git tree at the moment for the xilinx virtex
>>> stuff.  I can certainly create and maintain one if there is demand.  I
>>> guess it depends on how many people want to colaborate on V2Pro/V4
>>> support.  Anyone else interested?
>>
>>
>> Yes. I am also working on a Virtex-4 system with Linux.
>> Do you support also a Linux 2.4 tree?
> Sorry, no.  I'm focusing on the 2.6 stuff.  IIRC, the Denx tree is
> tracking the virtex support in 2.4.
> 
> Are you strictly working on 2.4?  Or are you interested in 2.6 as well?
> 
> Cheers,
> g.
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
