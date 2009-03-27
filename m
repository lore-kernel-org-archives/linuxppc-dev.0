Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9FA34DDEEC
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 10:39:27 +1100 (EST)
Date: Sat, 28 Mar 2009 10:18:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: DTC sources move
Message-ID: <20090327231818.GD20387@yookeroo.seuss>
References: <49CCDFBD.6020602@monstr.eu>
	<fa686aa40903270857g7f1a3b64y93067cba5a7a6a28@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40903270857g7f1a3b64y93067cba5a7a6a28@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 27, 2009 at 09:57:25AM -0600, Grant Likely wrote:
> On Fri, Mar 27, 2009 at 8:16 AM, Michal Simek <monstr@monstr.eu> wrote:
> > Hi Ben,
> >
> > could you please move DTC to any generic location. I would like to use it for Microblaze cpu too.
> 
> Michal,
> 
> David Gibson is the one responsible for the in-tree dtc source, not
> Ben, and you should prepare the patches yourself to move dtc.

No, I'll do it myself.  As Jon says, we should update to a more recent
upstream dtc at the same time and in any case I'll need to update my
scripts for importing dtc into the kernel tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
