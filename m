Return-Path: <neko@genesi-usa.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id 0FA2CDE4FB
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 01:21:49 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so383959nfd.9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 08:21:38 -0700 (PDT)
Message-ID: <4808BC7B.6040702@genesi-usa.com>
Date: Fri, 18 Apr 2008 16:21:31 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
References: <1208105558.3026.137.camel@pmac.infradead.org>	
	<4807427B.3030902@genesi-usa.com>	
	<1208443057.9212.250.camel@pmac.infradead.org>	
	<48076A00.1080608@genesi-usa.com>
	<1208507048.6958.407.camel@pasglop>
In-Reply-To: <1208507048.6958.407.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Benjamin Herrenschmidt wrote:
>>> can't set environment variables from within Linux (and yes, we can
>>> probably improve on that too, but we let them setenv for themselves,
>> for
>>> now).
>> You really won't be improving on it because there's no reliable way to
>> pass setenv back to the firmware from userland :D
> 
> They aren't in nvram ? If they are and using the standard OF CHRP
> format, then we can.

They aren't (especially on Pegasos) and they aren't, so you can't.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
