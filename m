Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id B78AD67BFF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Dec 2006 02:15:50 +1100 (EST)
Message-ID: <4586AF66.6010301@gersys.de>
Date: Mon, 18 Dec 2006 16:10:30 +0100
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200B I2S driver
References: <BAY122-F958549D2AE5C2CEC3F7EDCAD60@phx.gbl>	<200612131356.50092.roman.fietze@telemotive.de>	<45869C06.5020507@gersys.de>
	<200612181546.09884.roman.fietze@telemotive.de>
In-Reply-To: <200612181546.09884.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Roman

Roman Fietze wrote:
> As of my curret knowledge it is definitely a problem to run IDE-DMA
> together with any access to the LocalPlus on the old B2 mask of the
> MPC5200. We did not have problems using the BestComm concurrently for
> IDE, FEC and the PSC (I2S+SPI codec mode) on either mask.

That's good news for me.

> No problem, I will mail you the same tar fiel I sent to Wolfgang. This
> includes the BestComm code and once more the drivers. It's derived
> work and GPL'd.

Thanks a lot. I'm looking forward to trying that out. I'll send you a 
note once I've got it run, but it'll take some time until I have a 
hardware to work on.

Stefan
