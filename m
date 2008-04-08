Return-Path: <htejun@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.237])
	by ozlabs.org (Postfix) with ESMTP id 30112DDE06
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 00:48:52 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1923935wxd.15
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Apr 2008 07:48:51 -0700 (PDT)
Message-ID: <47FB85CB.2070506@gmail.com>
Date: Tue, 08 Apr 2008 23:48:43 +0900
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 6/13] devres: implement managed iomap interface
References: <11684073371547-git-send-email-htejun@gmail.com>
	<47FA4FD2.8060808@ru.mvista.com>
In-Reply-To: <47FA4FD2.8060808@ru.mvista.com>
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
>    A very late comment but nevertheless... :-)

Better late than never.

>    Those functions are going to break on 32-bit platforms with extended 
> physical address (well, that's starting with Pentiums which had 36-bit 
> PAE :-) AND devices mapped beyond 4 GB (e.g. PowerPC 44x).  You should 
> have used resource_size_t for the 'offset' parameter. As this most 
> probably means that libata is broken on such platforms, I'm going to 
> submit a patch...

Yeah, right please go ahead.  But I wonder whether any BIOS was actually 
crazy enough to map mmio region above 4G on 32bit machine.

-- 
tejun
