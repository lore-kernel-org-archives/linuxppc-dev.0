Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id BC3E8DDEE7
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 09:18:50 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so6371ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 15:18:49 -0700 (PDT)
Message-ID: <48FFA6C8.9020606@genesi-usa.com>
Date: Wed, 22 Oct 2008 17:18:48 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: Extended Addressing Mode
References: <48FEEB88.6050505@kontron.com>	<83735324-C37B-4C57-A50F-FFF0D133E4E3@kernel.crashing.org>	<48FF23C4.5030408@kontron.com>
	<88C8EDEB-C9A5-4876-AF7D-55CBABBE111D@kernel.crashing.org>
	<48FF2DDE.9060301@genesi-usa.com>
	<DC24FCF5-F410-47AB-8FC0-592EA0906568@kernel.crashing.org>
	<48FF3685.5020504@genesi-usa.com>
	<EF781CC4-B321-4E6A-A376-ADDDC1BB2E7B@kernel.crashing.org>
	<48FF6CEF.8050607@genesi-usa.com>
	<20EAA623-DD71-46E0-A47C-658DCEA7E607@freescale.com>
In-Reply-To: <20EAA623-DD71-46E0-A47C-658DCEA7E607@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	=?ISO-8859-1?Q?Odey=E9?= <regis.odeye@kontron.com>,
	=?ISO-8859-1?Q?R=E9gis_?=
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Becky Bruce wrote:
> 
> On Oct 22, 2008, at 1:11 PM, Matt Sealey wrote:
> 
>> Yeah so I saw BookE and e500 stuff go past but nothing specific for 
>> e600/XAEN. I mailed Becky and got no response. I'm glad to know it's 
>> in there though, somewhere.
> 
> Huh?  I have one mail from you, on Sep 1, to which I responded on Sep 
> 2.  Was there another mail I missed, or did you not see my response?  
> Freescale's mail server is unreliable, and since I'm not in the habit of 
> ignoring emails, feel free to nag me anytime if you send me something 
> and don't get a response.

Between Freescale's mail server and the trouble we're having 
with Google right now (along with thousands of others), I am 
NOT surprised it got lost somewhere along the way.

I wasn't bitching :)

>> Just so it has been asked, do you know in a broad sense what it would 
>> take to add the non-contiguous memory mapping support? Doesn't ppc64 
>> already have this?
> 
> PPC64 has SPARSEMEM support, IIRC. It's non-trivial to add for 32-bit, 
> although I haven't scoped it out in any detail.

Okay, non-trivial was pretty much what I was looking for, I 
was just trying to weigh up how much effort is required..

If you actually scope it out in any detail or someone has some 
10% time and decides this would be an awesome project, give me 
a nudge? My MPC8641D is itching to actually do something 
besides build packages. Actually having 8GB of memory would 
REALLY help run SUSE Build Service :]

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
