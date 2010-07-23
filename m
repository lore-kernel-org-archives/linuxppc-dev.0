Return-Path: <tmarri@apm.com>
Received: from exprod5og113.obsmtp.com (exprod5og113.obsmtp.com [64.18.0.26])
	by ozlabs.org (Postfix) with SMTP id 8C256B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Jul 2010 07:44:43 +1000 (EST)
Received: by qyk8 with SMTP id 8so579595qyk.12
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 14:44:41 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1279846638-22323-1-git-send-email-tmarri@amcc.com>
	<201007230815.14464.sr@denx.de>
In-Reply-To: <201007230815.14464.sr@denx.de>
MIME-Version: 1.0
Date: Fri, 23 Jul 2010 14:39:24 -0700
Message-ID: <8c2fc4da25db867b7daa7c4f618230b0@mail.gmail.com>
Subject: RE: [PATCH] Adding ADMA support for PPC460EX DMA engine.
To: Stefan Roese <sr@denx.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-raid@vger.kernel.org, dan.j.williams@intel.com,
	linux-crypto@vger.kernel.org, tmarri@amcc.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>As you describe above, a lot of the code seems to be copied from
>drivers/dma/ppc4xx/adma.c/h. Wouldn't it make more sense to factor out
the
>common code instead of duplicating it?



  Hi Stefan,
     Thanks for the review. There are definitely some functions can be
moved to a common file.

  Hi Dan,
 Could you also please review and see if there are any changes needed, so
I can include some changes as
Well in the modified patch.


Regards,
Marri
