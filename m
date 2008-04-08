Return-Path: <htejun@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 1B573DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 01:03:55 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so360131ywj.39
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Apr 2008 08:03:44 -0700 (PDT)
Message-ID: <47FB8948.9090302@gmail.com>
Date: Wed, 09 Apr 2008 00:03:36 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
References: <11684073371547-git-send-email-htejun@gmail.com>
	<47FA4FD2.8060808@ru.mvista.com> <47FB85CB.2070506@gmail.com>
	<47FB8751.3040301@ru.mvista.com>
In-Reply-To: <47FB8751.3040301@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:
>> Yeah, right please go ahead.  But I wonder whether any BIOS was 
>> actually crazy enough to map mmio region above 4G on 32bit machine.
> 
>    This is a *hardware* mapping on some non-x86 platforms (like PPC 44x 
> or MIPS Alchemy). The arch/ppc/ and arch/mips/ kernels have special 
> hooks called from ioremap() which help create an illusion that the PCI 
> memory space on such platforms (not only it) is mapped below 4 GB; 
> arch/powerpc/ kernel doesn't do this anymore -- hence this newly 
> encountered issue.

Ah... I see.  Thanks for the clarification.

-- 
tejun
