Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B3A05DDF90
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 08:52:56 +1100 (EST)
Message-Id: <5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18418.2460.594352.712502@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
Date: Tue, 1 Apr 2008 16:52:49 -0500
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<18418.2460.594352.712502@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 1, 2008, at 5:08 AM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> Normally we assume kernel images will be loaded at offset 0. However
>> there are situations, like when the kernel itself is running at a  
>> non-zero
>> physical address, that we don't want to load it at 0.
>>
>> Allow the wrapper to take an offset.  We use this when building u- 
>> boot images.
>
> This makes it a bit harder to build a kernel and then wrap it later
> on, since one would have to know what -m value to give.  Would it
> possible for either the wrapper script or mkimage to peek in the ELF
> header of the vmlinux to work out what physical address to use?

Hmm, need to think about that.  But my initial reaction is two fold.   
One I don't think this information would be around and two don't we  
already have this problem with a kdump kernel?

- k
