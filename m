Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from imagateway.smiths-aerospace.com (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 6737167A7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 01:37:44 +1100 (EST)
Message-ID: <41F659B1.1040603@smiths-aerospace.com>
Date: Tue, 25 Jan 2005 09:37:37 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: chao yu <chaoyu5201314@yahoo.com>
References: <20050125012333.17213.qmail@web90003.mail.scd.yahoo.com>
In-Reply-To: <20050125012333.17213.qmail@web90003.mail.scd.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: About I-cache and D-cache of MPC8245
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

chao yu wrote:
> Hi, All
>         I am a newbie in embeded system from China, recently i enable 
> the I-cache and D-cache of MPC8245. But it will crash. What the cause 
> might be? I have set the ICE and DCE filed of HID0 reg. and WIMG field 
> of BAT reg. Who can give me a hand? Thanks.
>  
> Regard,
> Yu.Chao

Your SDRAM initialization is probably not correct.  When you turn on 
caches, the processor starts doing burst reads of the SDRAM and that is 
when SDRAM initialization problems show up.

<http://www.denx.de/twiki/bin/view/DULG/UBootCrashAfterRelocation>

gvb
