Return-Path: <tur@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 36A2EDDF86
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 03:47:45 +1000 (EST)
Message-ID: <46C091A1.8000705@semihalf.com>
Date: Mon, 13 Aug 2007 19:15:13 +0200
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 and Bestcomm
References: <9e4733910708130927l70163a80vf0362ee8649a6c29@mail.gmail.com>
	<fa686aa40708130934v912eda2r691d2db30a9bc17c@mail.gmail.com>
In-Reply-To: <fa686aa40708130934v912eda2r691d2db30a9bc17c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 8/13/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>> We're starting a new MPC5200 project and I'm trying to track down 
>> the best kernel to start from. Is Sylvain's tree at 
>> http://www.246tnt.com/mpc52xx/ a good place to start? The git URLs
>>  from the web page don't work. Everything 5200 related in the trees
>>  at Secret Labs already appears to be merged.
>> 
>> Most of this work also appears to be in the Open Embedded tree's 
>> Ekifa support. Is that a better place to start?
> 
> It might be.  The major problem with MPC5200 is the Ethernet driver.
>  I believe both Domen and Sylvain have been working on drivers 
> suitable for arch/powerpc inclusion.

We have integrated FEC code floating around into DENX Linux 2.6 tree,
and have it working on several boards in the arch/powerpc context.

It might be worthwhile to check out
git://www.denx.de/git/linux-2.6-denx.git#linux-2.6-denx

HTH,
Bartlomiej
