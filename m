Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id E6CECDE83B
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 01:27:49 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so362719ugf.0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 08:27:47 -0700 (PDT)
Message-ID: <487CC1F5.5090706@genesi-usa.com>
Date: Tue, 15 Jul 2008 16:27:49 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: 2.6.26 does not boot on Pegasos
References: <20080715100033.GA5147@iram.es>
In-Reply-To: <20080715100033.GA5147@iram.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If you built this kernel yourself, you need to do it from a system with
an up-to-date binutils (2.18) otherwise, it does this.

If you got it from somewhere (like a distribution) then please tell us
where, as there are some other troubles with load-base location for
Fedora and so on...

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Gabriel Paubert wrote:
> 	Hi,
> 
> I just tried to boot 2.6.26 on a Pegasos and the kernel does not boot.
> The last message I have is:
> gunzip (0xffffffff <----- some more hex digits)
> 
> The configuration has been created from a working 2.6.25 one with
> make oldconfig and answering N to new config options.
> 
> Anybody has seen this or do I have to start digging deeper?
> 
> 	Regards,
> 	Gabriel
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
