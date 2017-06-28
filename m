Return-Path: <matthew.weber@rockwellcollins.com>
Received: from secvs01.rockwellcollins.com (secvs01.rockwellcollins.com
 [205.175.225.240])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyT5t3qhczDr3n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 02:39:29 +1000 (AEST)
Received: by mail-yb0-f199.google.com with SMTP id o81so47807517ybg.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 09:30:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170430070144.5ofjqykho5fmf2ah@home.buserror.net>
References: <1493315980-28480-1-git-send-email-matthew.weber@rockwellcollins.com>
 <20170430070144.5ofjqykho5fmf2ah@home.buserror.net>
From: Matthew Weber <matthew.weber@rockwellcollins.com>
Date: Wed, 28 Jun 2017 11:30:49 -0500
Message-ID: <CANQCQpZ+bg2r7LZSXvRdFqnj-R4JCbHtj+Et80RSo_-Smn4EcQ@mail.gmail.com>
Subject: Re: [1/1] powerpc/traps : Updated MC for E6500 L1D cache err
To: Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org,
 Ronak Desai <ronak.desai@rockwellcollins.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott,

On Sun, Apr 30, 2017 at 2:01 AM, Scott Wood <oss@buserror.net> wrote:
> On Thu, Apr 27, 2017 at 12:59:40PM -0500, Matt Weber wrote:
>> This patch updates the machine check handler of Linux kernel to
>> handle the e6500 architecture case. In e6500 core, L1 Data Cache Write
>> Shadow Mode (DCWS) register is not implemented but L1 data cache always
>> runs in write shadow mode. So, on L1 data cache parity errors, hardware
>> will automatically invalidate the data cache but will still log a
>> machine check interrupt.
>>
>> Signed-off-by: Ronak Desai <ronak.desai@rockwellcollins.com>
>> Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>

<snip>

Sent a v2 this morning, sorry about the delay.
https://patchwork.ozlabs.org/patch/781763/


Matt
