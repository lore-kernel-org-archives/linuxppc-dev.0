Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "Cisco Appliance Demo Certificate",
 Issuer "Cisco Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7ABB92C02B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 23:16:37 +1000 (EST)
Message-ID: <1370006175.5199.143.camel@zakaz.uk.xensource.com>
Subject: Re: DTB build failure due to preproccessing
From: Ian Campbell <Ian.Campbell@citrix.com>
To: Jon Loeliger <jdl@jdl.com>
Date: Fri, 31 May 2013 14:16:15 +0100
In-Reply-To: <E1UiOxz-0004ET-RE@jdl.com>
References: <1369996170.5199.68.camel@zakaz.uk.xensource.com>
 <20130531114824.60D223E0901@localhost> <E1UiOxz-0004ET-RE@jdl.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Michal Marek <mmarek@suse.cz>, Stephen Warren <swarren@nvidia.com>,
 linux-kbuild@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-05-31 at 08:01 -0500, Jon Loeliger wrote:
> Hrm.  Is this a "that's not in the kernel's copy yet" problem? 

BTW I'm using dtc.git 4e76ec796c90d44d417f82d9db2d67cfe575f8ed and not
the kernel copy. 

dtc-lexer.l in my HEAD is identical to the current master
(2e3fc7e9b3a4722a5500afaa9faf7874c61b2e6a) according to git diff.

Ian.
