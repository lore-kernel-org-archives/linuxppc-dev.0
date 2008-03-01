Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id E59E6DDE3A
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 09:25:30 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so5269401pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 01 Mar 2008 14:25:28 -0800 (PST)
Date: Sat, 1 Mar 2008 16:25:18 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2 v2] [OF] Add of_device_is_available function
Message-ID: <20080301162518.0e9621c0@vader.jdub.homelinux.org>
In-Reply-To: <20080302090218.2c99976f.sfr@canb.auug.org.au>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080302090218.2c99976f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2 Mar 2008 09:02:18 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Josh,
> 
> On Sat, 1 Mar 2008 08:16:00 -0600 Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> >
> > IEEE 1275 defined a standard "status" property to indicate the
> > operational status of a device.  The property has four possible values:
> > okay, disabled, fail, fail-xxx.  The absence of this property means the
> > operational status of the device is unknown or okay.
> > 
> > This adds a function called of_device_is_available that checks the state
> > of the status property of a device.  If the property is absent or set to
> > either "okay" or "ok", it returns 1.  Otherwise it returns 0.
> > 
> > Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> 
> Looks good to me - except the patch is word wrapped (which is weird for
> Claws) ...

That's weird indeed...  I've never had that happen before.  I'll resend.

josh
