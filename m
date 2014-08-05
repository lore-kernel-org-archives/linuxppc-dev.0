Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 518FC1A021A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 21:09:38 +1000 (EST)
Date: Tue, 5 Aug 2014 19:07:36 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Message-ID: <20140805110735.GA16503@MrMyself>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <53E0B926.9010103@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <53E0B926.9010103@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 Li.Xiubo@freescale.com, b42378@freescale.com, b02247@freescale.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Varka,

On Tue, Aug 05, 2014 at 04:29:50PM +0530, Varka Bhadram wrote:
> >diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >index 0f4e238..77864f4 100644
> >--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> >@@ -24,6 +24,22 @@ Required properties:
> >  - big-endian-data: If this property is absent, the little endian mode will
> >    be in use as default, or the big endian mode will be in use for all the
> >    fifo data.
> >+- fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> >+  that SAI will work in the synchronous mode (sync Tx with Rx) which means
> >+  both the transimitter and receiver will send and receive data by following
> >+  receiver's bit clocks and frame sync clocks.
> >+- fsl,sai-asynchronous: This is a boolean property. If present, indicating
> >+  that SAI will work in the asynchronous mode, which means both transimitter
> >+  and receiver will send and receive data by following their own bit clocks
> >+  and frame sync clocks separately.
> >
> Would be readable if it like this...
> 
> fsl,sai-synchronous-rx: This is a boolean property. If present, indicating
> 			that SAI will work in the synchronous mode (sync Tx with Rx) which means
> 			both the transimitter and receiver will send and receive data by following
> 			receiver's bit clocks and frame sync clocks.
> - fsl,sai-asynchronous: This is a boolean property. If present, indicating
> 			that SAI will work in the asynchronous mode, which means both transimitter
> 			and receiver will send and receive data by following their own bit clocks
> 			and frame sync clocks separately.

I agree, however, the doc was initialized in that format. Adding
indentations for these two appended lines makes the whole text
look weird. :(

Thank you,
Nicolin
