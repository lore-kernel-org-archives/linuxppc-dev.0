Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BEF6AB7D00
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 23:03:15 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] 460EX on-chip SATA driver<kernel 2.6.33> < resubmission :
	01>
Date: Wed, 17 Mar 2010 13:03:06 +0100
References: <1268646854-27387-1-git-send-email-rsarmah@appliedmicro.com>
	<AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201003171303.06258.sr@denx.de>
Cc: Rupjyoti Sarmah <rupjyoti.sarmah@appliedmicro.com>, linuxppc-dev@ozlabs.org,
	Rupjyoti Sarmah <rsarmah@amcc.com>, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, Rupjyoti Sarmah <rupjyoti.sarmah@gmail.com>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rup,

On Wednesday 17 March 2010 05:23:16 Rupjyoti Sarmah wrote:
> This patch enables the on-chip DWC SATA controller of the AppliedMicro
> processor 460EX.

Apart from the other comments, did you take a look at the latest version of 
this driver in our linux-2.6-denx repository? We did some work on this driver 
for a new Canyonlands release last year. It's hard to check this for me now, 
with this line wrapped patch (the drivers diverged somewhat). So either check 
for yourself, or send a new, not line-wrapped, patch version so that I can 
better check myself.

BTW: It would be nice if you would add me to Cc on DWC-SATA related patches, 
since I've been involved in the development at some time.

Thanks.

Cheers,
Stefan

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-0 Fax: (+49)-8142-66989-80 Email: office@denx.de
