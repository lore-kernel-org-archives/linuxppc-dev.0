Return-Path: <neko@genesi-usa.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.183])
	by ozlabs.org (Postfix) with ESMTP id 1E494DDEDC
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 00:10:14 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id v27so1076147ele.16
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 06:10:13 -0700 (PDT)
Message-ID: <47E3B4AF.3030505@genesi-usa.com>
Date: Fri, 21 Mar 2008 13:14:23 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: crash in init_ipic_sysfs on efika
References: <20080317195305.GA13298@aepfle.de>	<fa686aa40803202214k7d8596a5y922a34f33d33dca2@mail.gmail.com>
	<18403.31214.826941.838442@cargo.ozlabs.ibm.com>
In-Reply-To: <18403.31214.826941.838442@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is the MPC5200B PSC-AC97 driver in there?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Paul Mackerras wrote:
> Grant Likely writes:
> 
>> Confirmed, this patch fixes the problem.  Paulus or Kumar, can you
>> please pick it up for .25?
> 
> Sure, will do.  I thought about putting it in the last batch but I
> wanted an ack from you.
> 
> Anyone else got any last-minute things for 2.6.25?
> 
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
