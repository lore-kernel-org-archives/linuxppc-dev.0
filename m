Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sss9V04sHzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 18:25:49 +1100 (AEDT)
Message-ID: <1476084336.2471.43.camel@kernel.crashing.org>
Subject: Re: [PATCH] i2c_powermac: shut up lockdep warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Denis Kirjanov
 <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 10 Oct 2016 18:25:36 +1100
In-Reply-To: <871szo7omi.fsf@concordia.ellerman.id.au>
References: <1474457698-3855-1-git-send-email-kda@linux-powerpc.org>
 <CAOJe8K2N4bmNSSOjwwGBw9-wSXti1riyNHKs=7g38ph2J2zRgw@mail.gmail.com>
 <871szo7omi.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-10-10 at 16:35 +1100, Michael Ellerman wrote:
> > are you going to take this patch? The issue appears to me for a
> long time
> 
> I guess. Ben's response was a bit equivocal. But I guess he meant
> "seems
> OK". So yeah I'll pick it up for 4.10.

Yeah... seems ok. I haven't touched that code in many years...

Ben.
