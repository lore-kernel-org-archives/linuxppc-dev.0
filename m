Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17994B6F16
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 19:21:18 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: fushen chen <fchen@apm.com>
Subject: Re: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
Date: Thu, 1 Jul 2010 11:20:55 +0200
References: <12778468223309-git-send-email-fchen@apm.com>
	<201006301127.21241.sr@denx.de>
	<1277929012.16379.61.camel@localhost.localdomain>
In-Reply-To: <1277929012.16379.61.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007011120.55909.sr@denx.de>
Cc: Mark Miesfeld <mmiesfeld@apm.com>, Chuck Meade <chuck@theptrgroup.com>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fushen,

On Wednesday 30 June 2010 22:16:52 fushen chen wrote:
> The driver is based on Synopsys driver 2.60a.

OK.
 
> We started to prepare open source submission based on our internal
> version. We sync this version to linux-2.6-denx repository from time to
> time. I'll sync the driver to the latest linux-2.6-denx as Wolfgang
> pointed out, and re-submit patch to open source.

Thanks. I really appreciate this. A lot of effort has gone into this driver to 
fix some very troubling issues. And this driver version has undergone very 
intensive testing. So please make sure to integrate the changes/fixes. And 
please add myself and Chuck Meade <chuck@theptrgroup.com>, who did most of the 
bigger changes, to Cc on your new patch versions.
 
Thanks.

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
