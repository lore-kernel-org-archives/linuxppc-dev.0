Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR6jx1tY9zDqqN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 12:18:13 +1100 (AEDT)
Message-ID: <1516756684.7983.0.camel@russell.cc>
Subject: Re: [PATCH v4 0/7] SR-IOV Enablement on PowerVM
From: Russell Currey <ruscur@russell.cc>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 bodong@mellanox.com,  eli@mellanox.com, saeedm@mellanox.com
Date: Wed, 24 Jan 2018 12:18:04 +1100
In-Reply-To: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
References: <20180105164552.36371-1-bryantly@linux.vnet.ibm.com>
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

On Fri, 2018-01-05 at 10:45 -0600, Bryant G. Ly wrote:
> This patch series will enable SR-IOV on PowerVM. A specific set of
> lids for PFW/PHYP is required. They are planned to release with
> 920 at the moment.
> 
> For IBM internal testers let me know of a system you want to test on
> and we can put on the lids required or we can provide a system to run
> the tests.
> 
> This patch depends on the three patches:
> 988fc3ba5653278a8c14d6ccf687371775930d2b
> dae7253f9f78a731755ca20c66b2d2c40b86baea
> 608c0d8804ef3ca4cda8ec6ad914e47deb283d7b
> 
> v1 - Initial Patch
> v2 - Addressed Alexey and Russell's comments
> v3 - Unify the call of .error_detected()
> v4 - Fixed subject and change log per Bjorn's comments and
>      fixed Alexey's comments

For the whole series:

Acked-by: Russell Currey <ruscur@russell.cc>
