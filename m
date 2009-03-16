Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f174.google.com (mail-gx0-f174.google.com
	[209.85.217.174]) by ozlabs.org (Postfix) with ESMTP id 27EEFDDF26
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 03:22:45 +1100 (EST)
Received: by gxk22 with SMTP id 22so7796572gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 09:22:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090316161751.GA3622@orion>
References: <20090316161751.GA3622@orion>
Date: Mon, 16 Mar 2009 10:22:43 -0600
Message-ID: <fa686aa40903160922w7b2e20efxbb5aa5cd1621903e@mail.gmail.com>
Subject: Re: [PATCH next] powerpc/5200: fix building GPT driver without sysfs
From: Grant Likely <grant.likely@secretlab.ca>
To: Alexander Beregalov <a.beregalov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 16, 2009 at 10:17 AM, Alexander Beregalov
<a.beregalov@gmail.com> wrote:
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c: In function 'mpc52xx_gpt_create_attribs':
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c:373: error: parameter name omitted
> arch/powerpc/platforms/52xx/mpc52xx_gpt.c:373: warning: 'return' with a value, in function returning void
>
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

A patch has already been queued in the next branch of
git://git.secretlab.ca/git/linux-2.6-mpc52xx which removes the sysfs
code from this driver entirely.  Ben just hasn't pulled it into his
-next branch yet.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
