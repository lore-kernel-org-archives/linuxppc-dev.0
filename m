Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id 4187A2C0337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 00:14:05 +1100 (EST)
Message-ID: <526FB499.5090506@tabi.org>
Date: Tue, 29 Oct 2013 08:14:01 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and disable TIE/RIE
 in trigger()
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
 <526FA78D.2090601@tabi.org> <20131029121330.GB9605@MrMyself>,
 <526FACC1.7010909@tabi.org>
 <50y5h8hi19x5t2r9jhjrk097.1383051600782@email.android.com>
In-Reply-To: <50y5h8hi19x5t2r9jhjrk097.1383051600782@email.android.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Chen Guangyu-B42378 wrote:
> I mean there is a possibility.
>
>   I'm sorry if my patch is kinda annoying and it really bother you, sir. I also want to make things better.

It does not bother me.  I'm glad people are working on my driver.  I 
just want to make sure that my driver does not get bloated.

>
> If you really don't like it, we can drop it. It's all your call.

I think this patch should be dropped, because I don't see any real 
reason for it.
