Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B78FDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 06:29:22 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: DTC sources move 
In-reply-to: <fa686aa40903270857g7f1a3b64y93067cba5a7a6a28@mail.gmail.com> 
References: <49CCDFBD.6020602@monstr.eu>
	<fa686aa40903270857g7f1a3b64y93067cba5a7a6a28@mail.gmail.com>
Date: Fri, 27 Mar 2009 13:55:49 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1LnHDZ-0000Se-Sw@jdl.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, monstr@monstr.eu,
	devicetree-discuss@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Fri, Mar 27, 2009 at 8:16 AM, Michal Simek <monstr@monstr.eu> wrote:
> > Hi Ben,
> >
> > could you please move DTC to any generic location. I would like to use it f
> or Microblaze cpu too.
> 
> Michal,
> 
> David Gibson is the one responsible for the in-tree dtc source, not
> Ben, and you should prepare the patches yourself to move dtc.

And, I might add, please update it from its main repo in the process...

jdl
