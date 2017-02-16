Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPNt40kqdzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 04:48:11 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 13so1606171pgd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 09:48:11 -0800 (PST)
Received: from roar.ozlabs.ibm.com ([61.68.126.103])
 by smtp.gmail.com with ESMTPSA id x30sm14890315pgc.67.2017.02.16.09.48.07
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 16 Feb 2017 09:48:08 -0800 (PST)
Date: Fri, 17 Feb 2017 03:47:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC[PATCH 0/4] POWER9 machine check handler
Message-ID: <20170217034752.65cf9b65@roar.ozlabs.ibm.com>
In-Reply-To: <20170216170114.25247-1-npiggin@gmail.com>
References: <20170216170114.25247-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 17 Feb 2017 03:01:10 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> So far I've only got this tested in mambo simulator, but
> some recoverable and unrecoverable events seem to work.

Ugh, I forgot to update before sending sorry. It's just a
couple of small compiler bugs so I'll resend after getting
feedback first.

Thanks,
Nick
