Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 36C08DEA03
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 00:24:07 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so688257anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 07:24:05 -0700 (PDT)
Message-ID: <fa686aa40805200724m2feec4a1m131c6e1e3bd365a6@mail.gmail.com>
Date: Tue, 20 May 2008 08:24:05 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
In-Reply-To: <7A841A6C-137D-4784-B7B0-2BAFFFB0CCF7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080519174558.GA26229@polina.dev.rtsoft.ru>
	<20080519174651.GA28185@polina.dev.rtsoft.ru>
	<AAEC7B21-11B1-4922-9726-70E43DA3829B@kernel.crashing.org>
	<20080520123226.GB14573@polina.dev.rtsoft.ru>
	<7A841A6C-137D-4784-B7B0-2BAFFFB0CCF7@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 7:15 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>> There (and in the QE GPIO) was an arch_initcall, but based on
>> Grant Likely's review it was removed in favour of platform-specific
>> machine_initcalls.
>>
>> See http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg16469.html
>> There I was trying to argue, but quickly gave up. ;-) I don't have any
>> strong preference for this anyway. I can do either way, just tell which
>> you prefer.
>
> I'd prefer the arch_initcall().  If its the board that is going to do the
> Kconfig select on this that seems sufficient to say do "init" for me w/o an
> explicit call to it.

That's only true if the assumption is that you are not building a
multiplatform kernel.  I'd rather see platform code in control of
registering devices.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
