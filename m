Return-Path: <B42378@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E3CA22C0357
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 00:17:56 +1100 (EST)
From: Chen Guangyu-B42378 <B42378@freescale.com>
To: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and disable TIE/RIE in
 trigger()
Date: Tue, 29 Oct 2013 13:16:52 +0000
Message-ID: <df3ajlgpavhroiiray67at4q.1383052621653@email.android.com>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
 <526FA78D.2090601@tabi.org>
 <20131029121330.GB9605@MrMyself>,<526FACC1.7010909@tabi.org>
 <50y5h8hi19x5t2r9jhjrk097.1383051600782@email.android.com>,
 <526FB499.5090506@tabi.org>
In-Reply-To: <526FB499.5090506@tabi.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
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

As you wish, sir.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Chen Guangyu-B42378 wrote:
> I mean there is a possibility.
>
>   I'm sorry if my patch is kinda annoying and it really bother you, sir. =
I also want to make things better.

It does not bother me.  I'm glad people are working on my driver.  I
just want to make sure that my driver does not get bloated.

>
> If you really don't like it, we can drop it. It's all your call.

I think this patch should be dropped, because I don't see any real
reason for it.
