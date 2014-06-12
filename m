Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 374F11A02E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 18:09:16 +1000 (EST)
Message-ID: <53996027.70504@suse.cz>
Date: Thu, 12 Jun 2014 10:09:11 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc: Avoid circular dependency with zImage.%
References: <53984D4F.6040808@linux.vnet.ibm.com>
 <1402501243-28213-1-git-send-email-mmarek@suse.cz>
 <53990B48.8010902@linux.vnet.ibm.com>
In-Reply-To: <53990B48.8010902@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dne 12.6.2014 04:07, Mike Qiu napsal(a):
> This v2 patch is good,
> 
> Tested-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

Thanks. In kbuild.git it goes.

Michal
