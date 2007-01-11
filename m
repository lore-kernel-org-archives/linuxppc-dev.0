Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 19760DDEFC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Jan 2007 10:58:06 +1100 (EST)
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] Add cputable entry for PowerPC 440SPe Rev. B
References: <adalkk9dx7e.fsf@cisco.com>
	<1168559634.4217.8.camel@zod.rchland.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 11 Jan 2007 15:58:05 -0800
In-Reply-To: <1168559634.4217.8.camel@zod.rchland.ibm.com> (Josh Boyer's
	message of "Thu, 11 Jan 2007 17:53:54 -0600")
Message-ID: <adalkk99kvm.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > > Add a cputable entry for revision B of the AMCC 440SPe.  When adding
 > > this entry, we need to adjust the entry for 440SP Rev. A so that it
 > > matches more bits of the PVR, since the 440SPe Rev. B has PVR
 > > 53421891, which would match the old 440SP PVR pattern of 53xxx891.
 > 
 > Is Rev. B the one found on the AMCC Katmai board?

I would guess so -- it's the current rev.

I don't have a katmai board (just a yucca reworked with a rev. b chip)

 - R.
