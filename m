Return-Path: <hs@denx.de>
Received: from b.relay.invitel.net (b.relay.invitel.net [62.77.203.4])
	by ozlabs.org (Postfix) with ESMTP id B89A41007DD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 19:04:57 +1100 (EST)
Date: Tue, 25 Jan 2011 09:04:51 +0100
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/4 v4] video, sm501: add edid and commandline support
In-reply-to: <20110125075104.GJ11673@linux-sh.org>
To: Paul Mundt <lethal@linux-sh.org>
Message-id: <4D3E8423.1090106@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1295863047-11131-1-git-send-email-hs@denx.de>
	<20110125075104.GJ11673@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>, linuxppc-dev@lists.ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Paul,

Paul Mundt wrote:
> On Mon, Jan 24, 2011 at 10:57:27AM +0100, Heiko Schocher wrote:
>> @@ -1884,7 +1935,6 @@ static int __devinit sm501fb_probe(struct platform_device *pdev)
>>  
>>  	if (info->pdata == NULL) {
>>  		dev_info(dev, "using default configuration data\n");
>> -		info->pdata = &sm501fb_def_pdata;
>>  	}
>>  
>>  	/* probe for the presence of each panel */
> 
> I assume this is accidental? I don't see how you're compensating for this
> in any of the other patches at least, as it's orthogonal from the default
> mode settings.

Seems so, rework this too, thanks!

bye,
heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
