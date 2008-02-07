Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 46604DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 16:12:10 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so911268anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Feb 2008 21:12:09 -0800 (PST)
Message-ID: <fa686aa40802062112u70f09f5fk46d2efd7c5e52cb3@mail.gmail.com>
Date: Wed, 6 Feb 2008 22:12:09 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Olof Johansson" <olof@lixom.net>
Subject: Re: Fwd: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <20080207025200.GA31374@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40802061333kd6567bay92c530bb08a2aac8@mail.gmail.com>
	<fa686aa40802061334u5700bbf3ua3bbf6d967c9b2cc@mail.gmail.com>
	<20080207025200.GA31374@lixom.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Rigby John-R61273 <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/6/08, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Wed, Feb 06, 2008 at 02:34:24PM -0700, Grant Likely wrote:
>
> > John Rigby (4):
> >       [POWERPC] mpc512x: Basic platform support
> >       [POWERPC] mpc512x: Device tree for MPC5121 ADS
> >       [POWERPC] mpc512x: Factor out 5200 dependencies from 52xx psc driver
> >       [POWERPC] mpc512x: Add MPC512x PSC support to MPC52xx psc driver
>
> mpc52xx_defconfig no longer builds for me, and the two latter of the
> above patches are the ones that touch that file:

Gah!  I caused some patch damage when I rebased the patches.  I'll
send a fixup patch ASAP.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
