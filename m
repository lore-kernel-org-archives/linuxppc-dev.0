Message-Id: <5.1.0.14.2.20030305131034.02661008@falcon.si.com>
Date: Wed, 05 Mar 2003 13:12:18 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: mpc8241/8245 floating point unit
In-Reply-To: <00019598.C22236@devcom.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It has always had a FPU.  For a while, Mot was not advertising it because
they had not verified that it worked properly, but it is an advertised
feature now.  It has always worked.

gvb


At 12:23 PM 3/5/2003 -0500, jan.damborsky@devcom.cz wrote:
>Jerry Van Baren wrote:
>
> >
> > I don't have 8241/8245 experience, but I do have 8260 experience (also
> > uses
> > the 603e core).  Floating point (FPU) works well under linux.
>
>Does 8260 really have full FPU support ?. I think it only has FPU
>register set and it supports
>FPU load and store instructions, but NOT arithmetic instructions. Am I
>right ?
>                   HANYS


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
