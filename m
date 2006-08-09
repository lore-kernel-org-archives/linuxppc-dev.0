Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7669667BA2
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 22:29:56 +1000 (EST)
Message-ID: <44D9D532.9010200@sipsolutions.net>
Date: Wed, 09 Aug 2006 14:29:38 +0200
From: Johannes Berg <johannes@sipsolutions.net>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] Linux v2.6.18-rc4, snd-aoa link error
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>	<20060808194651.GA29482@aepfle.de>	<1155067429.26338.96.camel@mindpipe>	<s5hoduudypc.wl%tiwai@suse.de>	<44D9B1BE.9070600@sipsolutions.net>	<s5hk65idwia.wl%tiwai@suse.de>	<44D9C8E5.10109@sipsolutions.net>
	<s5h7j1idrvf.wl%tiwai@suse.de>
In-Reply-To: <s5h7j1idrvf.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Lee Revell <rlrevell@joe-job.com>,
	alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Takashi Iwai wrote:
>> Yeah, I really should know :) But I'm not sure at the moment, and the 
>> powermac I own is a few hundred kilometers away...
>>     
>
> Don't worry, we can wait :)
>   
Maybe someone on linuxppc-dev can quickly check? Does a G5 use 
I2C_POWERMAC for access to the codecs? I think it does, but there are 
other I2C busses as well.
>> That looks good to me, and should get rid of the build failure. However, 
>> if one doesn't configure I2C_POWERMAC, no codec will ever be found at 
>> runtime.
>>     
>
> Yes, that's my concern, too.
>   
I'm not sure how much we should force the users to a sensible 
configuration ;) But I suppose selecting I2C_POWERMAC is fine for all 
relevant machines for now.

johannes
