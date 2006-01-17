Return-Path: <Tom.Ziomek@motorola.com>
Received: from motgate3.mot.com (motgate3.mot.com [144.189.100.103])
	by ozlabs.org (Postfix) with ESMTP id 05BBC68926
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 07:25:12 +1100 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by motgate3.mot.com (8.12.11/Motgate3) with ESMTP id k0HKhvbE010697
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 13:43:57 -0700 (MST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by az33exr03.mot.com (8.13.1/8.13.0) with ESMTP id k0HKbrMr008923
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jan 2006 14:37:53 -0600 (CST)
Date: Tue, 17 Jan 2006 14:23:37 -0600 (Central Standard Time)
From: T Ziomek <ctz001@email.mot.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 00/10] Updated ML300 & ML403 patches
In-Reply-To: <43CD5144.1070401@secretlab.ca>
Message-ID: <Pine.WNT.4.61.0601171420460.2664@holyoke.labs.mot.com>
References: <mailman.134.1137523561.17753.linuxppc-embedded@ozlabs.org>
	<Pine.WNT.4.61.0601171341520.2664@holyoke.labs.mot.com>
	<43CD5144.1070401@secretlab.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: T Ziomek <Tom.Ziomek@motorola.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 17 Jan 2006, Grant Likely wrote:
>
> T Ziomek wrote:
>> 
>> Grant Likely wrote:
>> 
>>> John Bonesio wrote:
  . . .
>>>> I'm replying to this email thread because Grant suggested there be a GIT
>>>> tree for Virtex specific changes.
>>> 
>>> I was told today that we may be able to use Paul's linuxppc tree.  I'm
>>> going to ask him later today.
>> 
>> Probably a newbie question...my understanding is that kernel.org is the
>> preferred repository for PPC-specific code these days, correct?  So the a-
>> bove is referring to Xilinx-specific PPC code?  From what I can see on LXR
>> and kernel.org neither has any Xilinx-related code...
>
> mainline linux-2.6 tree has ml300 support
>
> ml300 platform bus support is pending for the powerpc.git tree
> ml403 support is pending for the powerpc.git tree
>
> powerpc.git is periodically pulled into linux-2.6
>
> both are on kernel.org

Meh, okay.  But then what are the "Virtex specific changes" that would need
to be in Paul's linuxppc tree or anywhere but kernel.org?

Thanks, Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
