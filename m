Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.241])
	by ozlabs.org (Postfix) with ESMTP id 8BA84DDF66
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 10:17:22 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so577678agc.0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 15:17:21 -0800 (PST)
Message-ID: <fa686aa40801101517q2d4e6673l995ef4123f0d0ad4@mail.gmail.com>
Date: Thu, 10 Jan 2008 16:17:20 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH v2] [ALSA] Add ASoC drivers for the Freescale
	MPC8610 SoC
In-Reply-To: <4786A650.2080107@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
	<12000050682718-git-send-email-timur@freescale.com>
	<fa686aa40801101502v264d8caw6faf935d71b15c9@mail.gmail.com>
	<4786A650.2080107@freescale.com>
Cc: olof@lixom.net, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/10/08, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
>
> > Does the driver access the DMA and GUTS registers directly?  If so,
> > what do you have to protect against race conditions of other drivers
> > accessing them also.
>
> I don't have any more protection than any other driver that accesses SOC
> registers directly.  Last I heard, Zhang's DMA driver was in limbo, and that
> driver would be the best place to arbitrate DMA register access.  I was planning
> on adding arbitration support to that driver after both drivers were applied.

That sounds appropriate

>
> As for the GUTS driver, well, I just program a few registers at startup, and I
> don't think any other driver touches them.

Okay; at some point in the future they'll need to be accessed from a
common routine too.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
