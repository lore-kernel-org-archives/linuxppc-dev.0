Return-Path: <htejun@gmail.com>
Received: from po-out-1718.google.com (po-out-1718.google.com [72.14.252.158])
	by ozlabs.org (Postfix) with ESMTP id 03E6DDE015
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 12:08:44 +1000 (EST)
Received: by po-out-1718.google.com with SMTP id y22so404528pof.4
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 19:08:43 -0700 (PDT)
Message-ID: <47FEC823.9000100@gmail.com>
Date: Fri, 11 Apr 2008 11:08:35 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
References: <11684073371547-git-send-email-htejun@gmail.com>	<47FA4FD2.8060808@ru.mvista.com>
	<47FB85CB.2070506@gmail.com> <47FB8751.3040301@ru.mvista.com>
	<47FE46AC.5000901@ru.mvista.com>
	<59A939C7-75AF-4C0F-8199-4C31D174AEA9@kernel.crashing.org>
	<47FE5B76.40409@ru.mvista.com>
	<A567023C-17FC-402D-9394-29DFFA816891@kernel.crashing.org>
In-Reply-To: <A567023C-17FC-402D-9394-29DFFA816891@kernel.crashing.org>
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

Kumar Gala wrote:
>>> but there is no reason not to make it work properly.  For example I  
>>> believe libata uses devm_* and the fsl SATA driver (non-PCI) will 
>>> need  to work in cases similar to the 44x.
>>
>>   Well, as for sata_fsl, it calls of_iomap() which does The Right Thing.
> 
> Fair, but I don't see why we should introduce new APIs that are already 
> "broken".  We went through a lot of effort to clean up and introduce 
> resource_t (and clearly still have some bugs) for the >32-bit physical 
> address problem.

Yes, please go ahead.  In case it wasn't clear, I wasn't objecting to 
the fix at all.  I was just curious what could actually happen on x86.

-- 
tejun
