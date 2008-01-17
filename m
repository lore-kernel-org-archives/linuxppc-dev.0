Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id AAE5FDDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 01:29:17 +1100 (EST)
Message-ID: <478F6672.202@semihalf.com>
Date: Thu, 17 Jan 2008 15:30:10 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 02/13] [POWERPC] Add 'fsl, lpb' bus type for MPC5200
	LocalPlus Bus
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>	
	<20071109171149.16289.88635.stgit@hekate.izotz.org>
	<fa686aa40801021537h58ed2deehfd85c75871973758@mail.gmail.com>
In-Reply-To: <fa686aa40801021537h58ed2deehfd85c75871973758@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Grant,

Sorry, for the late reply.

Grant Likely wrote:
> On 11/9/07, Marian Balakowicz <m8@semihalf.com> wrote:
>> Define MPC52xx specific device id list, add new
>> 'fsl,lpb' compatible id for LocalPlus Bus.
> 
> I'll pick this up, but I'm going to drop the .compatible="soc" line.
> (I'd like to drop the device_type="soc" line also, but that requires a
> bit more thought first).

I finally got a chance to re-test my 5200 patches. I pulled
'for-2.6.25' branch from your tree where you already applied those
patches and adapted .dts and _defconfig files.

See '[POWERPC] Update TQM5200, CM5200 and Motion-PRO _defconfig and
.dts files' patch. It introduces necessary modification resulting from
the meantime development, so please pick this one up as well.

I got one more pending patch: '[POWERPC] Motion-PRO: Add LED support',
but that's the diver code and I am not sure who should be picking it
up, any ideas?

Thanks,
m.
