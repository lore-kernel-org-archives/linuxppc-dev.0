Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 1E67567A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Mar 2005 20:49:01 +1100 (EST)
Message-ID: <42243A82.2050109@varma-el.com>
Date: Tue, 01 Mar 2005 12:48:50 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: SWarren@nvidia.com, linuxppc-embedded@ozlabs.org,
	glikely@gmail.com
References: <DBFABB80F7FD3143A911F9E6CFD477B004F06D6C@hqemmail02.nvidia.com>
	<528646bc050228194513f04673@mail.gmail.com>
In-Reply-To: <528646bc050228194513f04673@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: NPTL on MPC5200
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
> On Mon, 28 Feb 2005 16:30:14 -0800, Stephen Warren <SWarren@nvidia.com> wrote:
> 
>>Does anybody know of any distros (commercial or otherwise) that support
>>the MPC5200 as a target and some any/all of:
>>
>>NPTL (Native Posix Threading Library)
>>ALSA
> 
> I've brought up Gentoo on my MPC5200 eval board (NFS root).  It
> supports ALSA and I'm pretty sure NPTL also.  I'm simply cutting back
> the files in the rootfs to fit onto my ultimate target.
> 

Same config, but I use Debian (mainly Woody, partially Sarge) with 
Sylvain's kernel AND with NPTL enabled in glibc.

--
Regards
Andrey Volkov
