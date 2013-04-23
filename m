Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0B3462C0169
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:32:45 +1000 (EST)
Message-ID: <1366695150.2886.14.camel@pasglop>
Subject: Re: [PATCH] powerpc/rtas_flash: New return code to indicate FW
 entitlement expiry
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ananth@in.ibm.com
Date: Tue, 23 Apr 2013 15:32:30 +1000
In-Reply-To: <20130423050540.GA30690@in.ibm.com>
References: <20130419114410.19115.35846.stgit@hegdevasant>
 <1366677610.2886.8.camel@pasglop> <20130423050540.GA30690@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-04-23 at 10:35 +0530, Ananth N Mavinakayanahalli wrote:
> On Tue, Apr 23, 2013 at 10:40:10AM +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2013-04-19 at 17:14 +0530, Vasant Hegde wrote:
> > > Add new return code to rtas_flash to indicate firmware entitlement
> > > expiry. This will be used by the update_flash script to return
> > > appropriate message to the user.
> > 
> > What's the point of that patch ? It adds a definition to a private .c
> > file not exposed to user space and doesn't do anything with it ...
> 
> Ben,
> 
> The userspace update_flash script invokes the rtas_flash module. With
> upcoming System p servers, the firmware will have the entitlement dates
> encoded in it and RTAS will return an error if the entitlement has
> expired. All we need from this module is for it to return that new error
> which will then be communicated to the user by the update_flash.

That doesn't answer my question :-)

What is the point of adding a #define to a piece of code without any user
of that definition and in a file that isn't exposed to user space ?

IE. What is the point of the patch ?

Cheers,
Ben.
