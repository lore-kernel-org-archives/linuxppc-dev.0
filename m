Return-Path: <rjw@rjwysocki.net>
Received: from v094114.home.net.pl (v094114.home.net.pl [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 15EBE1A0926
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 16:28:02 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V4] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
Date: Wed, 18 Feb 2015 06:51:12 +0100
Message-ID: <3335960.mm4nUDCbyI@vostro.rjw.lan>
In-Reply-To: <54E4186B.40605@linux.vnet.ibm.com>
References: <20150203061709.13097.7035.stgit@preeti.in.ibm.com>
 <4031451.QMQakQrpsN@vostro.rjw.lan> <54E4186B.40605@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, February 18, 2015 10:13:23 AM Preeti U Murthy wrote:
> 
> On 02/17/2015 11:23 PM, Rafael J. Wysocki wrote:
> > On Tuesday, February 17, 2015 01:29:10 PM Preeti U Murthy wrote:
> >> Hi Rafael,
> > 
> > Hi,
> > 
> >> Can you please pull this patch ?
> > 
> > Sorry, I wasn't sure whether or not the patch was for me to take and then
> > I've been traveling lately.  Applied now.
> 
> Hi Rafael,
> 
> I saw that the kbuild bot reported build issues around pr_warn() in this patch.
> I have fixed this and below is the corrected patch. Do let me know if I have
> to send it out as a separate version/RESEND tag.

I've applied it, thanks!

> >> Another patch based on top of this is waiting to be pulled:
> >> [PATCH] driver/cpuidle-powernv: Avoid endianness conversions while parsing DT
> > 
> > OK, have you posted it already?
> Yes I have. https://lkml.org/lkml/2015/2/3/24.

OK, so this one does not apply for me on top of the other.  Can you rebase it
on top of my current linux-next branch and resend it, please?

Also I'd appreciate it if someone could ACK DT-related stuff for me.

> This patch is also waiting to be pulled by you. There was some confusion
> around who should pull this, but since it all the code is in the driver, we
> thought it would be best if you pulled it.

Well, OK.  If you want me to apply a patch, send it To: me and not To: someone
else.  If you send it To: someone else, I'll ignore it.

Also ask people to review and ACK things you want me to pull, especially if
that's not stuff I'm particularly familiar with (like related to DT bindings
specific to your platform etc.).


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
