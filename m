Return-Path: <neko@genesi-usa.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.189])
	by ozlabs.org (Postfix) with ESMTP id 28794DDFC6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 19:53:26 +1000 (EST)
Received: by gv-out-0910.google.com with SMTP id y18so321517gvf.14
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Jun 2008 02:53:17 -0700 (PDT)
Message-ID: <48490909.4020901@genesi-usa.com>
Date: Fri, 06 Jun 2008 10:53:13 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: cntlzw
References: <4845A44D.20404@hypersurf.com> <4845A55E.2030503@freescale.com>
In-Reply-To: <4845A55E.2030503@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Kevin Diggs <kevdig@hypersurf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's in the Compiler Writer's Guide with explanation; section 5-10.

http://www-01.ibm.com/chips/techlib/techlib.nsf/techdocs/852569B20050FF7785256996007558C6

There are lots of clever examples in there, it's definitely recommended
reading (I should make a cheat sheet of chapter 5 though so I can pin it
to my wall)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Scott Wood wrote:
> Kevin Diggs wrote:
>> Hi,
>>
>>     x86 has bsf and bsr. PPC has cntlzw which I think is equivalent to 
>> bsr. Anyone know of a sneaky algorithm to do bsf?
> 
> wordsize - 1 - cntlzw(x & ~(x - 1));
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
