Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 89620DDE3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 18:49:01 +1000 (EST)
Message-ID: <46D68466.3060402@scram.de>
Date: Thu, 30 Aug 2007 10:48:38 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc32/8xx: Fix r3 trashing due to 8MB TLB page
	instantiation
References: <46D40510.3060805@scram.de>
	<611B8BA7-89B3-4DA0-A248-0FB57E4654ED@kernel.crashing.org>
In-Reply-To: <611B8BA7-89B3-4DA0-A248-0FB57E4654ED@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

> do we need this in arch/powerpc as well?

No. At least not until these patches are applied to powerpc, as well:

8f069b1a90bd97bf6d59a02ecabf0173d9175609 [PATCH] powerpc/8xx: Use 8MB D-TLB's for kernel static mapping faults
3ea4807de7b2c5c903380ba2c2e7150bee942f42 [PATCH] powerpc/8xx: last two 8MB D-TLB entries are incorrectly set
c51e078f82096a7d35ac8ec2416272e843a0e1c4 [PATCH] ppc32/8xx: Fix r3 trashing due to 8MB TLB page instantiation

Thanks,
Jochen
