Return-Path: <robherring2@gmail.com>
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LCSf2sQ5zF3Ld
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 08:35:29 +1000 (AEST)
Received: by mail-ot1-f66.google.com with SMTP id q4-v6so579491otf.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 15:35:29 -0700 (PDT)
Date: Wed, 26 Sep 2018 17:35:25 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Radu Rendec <radu.rendec@gmail.com>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: watchdog: add mpc8xxx-wdt support
Message-ID: <20180926223525.GA25002@bogus>
References: <c09f541d459c29aca40d54fff152d5645e24b50d.1537163776.git.christophe.leroy@c-s.fr>
 <e3e0bcfd7b779b978d07e088a8bd667ea9ddf4aa.1537163780.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e3e0bcfd7b779b978d07e088a8bd667ea9ddf4aa.1537163780.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 17 Sep 2018 06:22:53 +0000 (UTC), Christophe Leroy wrote:
> Add description of DT bindings for mpc8xxx-wdt driver which
> handles the CPU watchdog timer on the mpc83xx, mpc86xx and mpc8xx.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  .../devicetree/bindings/watchdog/mpc8xxx-wdt.txt   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/mpc8xxx-wdt.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
