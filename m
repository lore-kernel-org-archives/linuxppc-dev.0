Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPNl12Zs3zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 16:41:01 +1100 (AEDT)
Message-ID: <1458020454.30802.5.camel@russell.cc>
Subject: Re: [PATCH] powernv/hmi: Use the "unknown" checkstop type as a
 fallback
From: Russell Currey <ruscur@russell.cc>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 15 Mar 2016 16:40:54 +1100
In-Reply-To: <56E79F56.6050006@au1.ibm.com>
References: <1458012409-32448-1-git-send-email-ruscur@russell.cc>
 <56E787FE.1060104@au1.ibm.com> <1458018919.30802.4.camel@russell.cc>
 <56E79F56.6050006@au1.ibm.com>
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

On Tue, 2016-03-15 at 16:36 +1100, Andrew Donnellan wrote:
> On 15/03/16 16:15, Russell Currey wrote:
> > 
> > > 
> > > Would it be useful to print xstop_type in the unknown case?
> > I don't think so - if there's a new checkstop type, specific handling
> > for
> > it should be implemented in the kernel, and if you're getting unknown
> > checkstops that are bringing down your machine you should be looking at
> > the
> > OPAL firmware log anyway, which would contain details if there was
> > something "new".
> That's fair, would primarily help debugging in the rather corner case of 
> new skiboot, old kernel, and no access to the OPAL log...
> 
I think if you don't have access to the OPAL log, finding out what number
OPAL sent isn't going to help you.
