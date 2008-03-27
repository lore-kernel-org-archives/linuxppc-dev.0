Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.230])
	by ozlabs.org (Postfix) with ESMTP id 4457FDE0DB
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 00:27:10 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so4079302wxd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 06:27:09 -0700 (PDT)
Message-ID: <fa686aa40803270627r5c83f373kf5055a9c44d37300@mail.gmail.com>
Date: Thu, 27 Mar 2008 07:27:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: Missing patch for MPC5200B register definitions?
In-Reply-To: <47EA7687.5000102@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47EA7687.5000102@genesi-usa.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 10:15 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> I've just been looking into the MPC5200B AC97 driver breakage with the
>  latest Git kernel, and found the following patch;
>
>  http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035952.html
>
>  Is not in the latest tree. As such anything which uses the new MPC5200B
>  registers (especially important on AC97 and probably not used otherwise)
>  has not or was not applied.
>
>  Since the latest kernel source from git actually includes the MPC5121E
>  differences, I assume this is a regression?
>
>  How do we go about fixing this?

Write a patch to apply that change in arch/powerpc and post it to the
list.  If it looks good, I'll pick it up.

BTW, did you figure out if the AC97 driver is being picked up by the
ALSA maintainers?

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
