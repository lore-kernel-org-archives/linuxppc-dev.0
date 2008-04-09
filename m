Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.225])
	by ozlabs.org (Postfix) with ESMTP id 1B592DDFBD
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 01:26:06 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2534102wxd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Apr 2008 08:26:04 -0700 (PDT)
Message-ID: <fa686aa40804090826j1cd5c9c2t3bd95eeb9e356a48@mail.gmail.com>
Date: Wed, 9 Apr 2008 09:26:04 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
In-Reply-To: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 9, 2008 at 9:18 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> Board specific defconfigs are useful, however with the ability to do
>  multi-board defconfigs they aren't needed in the top level configs directory
>
>  Move the 83xx/85xx board specific defconfigs to individual directories under
>  arch/powerpc/configs.
>
>  Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
