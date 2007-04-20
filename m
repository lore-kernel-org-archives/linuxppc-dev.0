Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 0D860DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Apr 2007 00:02:54 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so732081ugf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 07:02:51 -0700 (PDT)
Message-ID: <528646bc0704200702i328ba9dbvc62473e5a634d5ac@mail.gmail.com>
Date: Fri, 20 Apr 2007 08:02:51 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: FDT for MPC5200, CPU revision, MSCAN
In-Reply-To: <46286A0F.9080608@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <462864CA.7050601@grandegger.com> <46286A0F.9080608@grandegger.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/20/07, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Wolfgang Grandegger wrote:
> > Hello,
> >
> > is there a way to distinguish the CPU revision (Rev.A vs. Rev.B) of the
> > MPC5200, preferably at run time? Or should this be defined in the FDT?
> > I ask, because some settings depend on the CPU revision due to hardware
> > bugs, like the clock source used for MSCAN.

This stuff is defined in the device tree.  If you need to detect the
version at runtime, then ideally your bootloader will read the PVR/SVR
to determine the chip version and then pass the correct FDT to the
kernel.

> I found the information here:
>
> $ cat Documentation/powerpc/mpc52xx-device-tree-bindings.txt
<snip>
> Sorry for the noise.

Not noise; good question.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
