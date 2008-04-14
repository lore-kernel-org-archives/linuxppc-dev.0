Return-Path: <jirislaby@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by ozlabs.org (Postfix) with ESMTP id 27125DE03A
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 23:54:27 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so1417156fgg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 06:54:25 -0700 (PDT)
Message-ID: <4803620C.6020905@gmail.com>
Date: Mon, 14 Apr 2008 15:54:20 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
References: <12053582234100-git-send-email-yorksun@freescale.com>	<12053582231281-git-send-email-yorksun@freescale.com>	<47D8572C.8090501@gmail.com>	<47FFDBFF.1030809@gmail.com>
	<20080411221817.0b1eb414.akpm@linux-foundation.org>
	<48035E93.6070300@freescale.com> <48035F98.1020404@gmail.com>
	<48036001.10905@freescale.com>
In-Reply-To: <48036001.10905@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	York Sun <yorksun@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 04/14/2008 03:45 PM, Timur Tabi wrote:
> Jiri Slaby wrote:
> 
>> See
>> http://lkml.org/lkml/2008/3/12/375
> 
> That email is dated 3/12 and those comments are about v1 of the patch.  The most
> recent posted version is v5 and it addresses all these issues.  See
> http://lkml.org/lkml/2008/4/1/346

Ok, how is the sleep-inside-spinlock in fsl_diu_open resolved? rh_alloc might 
sleep if I still see correctly, do I?
