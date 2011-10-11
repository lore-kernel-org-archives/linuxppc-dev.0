Return-Path: <tmarri@apm.com>
Received: from exprod5og112.obsmtp.com (exprod5og112.obsmtp.com [64.18.0.24])
 by ozlabs.org (Postfix) with SMTP id 224CEB6F72
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2011 09:54:09 +1100 (EST)
Received: by iaeo4 with SMTP id o4so205821iae.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2011 15:54:07 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <1317954632-11768-1-git-send-email-tmarri@apm.com>
 <CAKwPUowTCS2jO1QdFMCFg86Mb_d_yo2NvnWQ=Lh6N1tdgZE1rA@mail.gmail.com>
In-Reply-To: <CAKwPUowTCS2jO1QdFMCFg86Mb_d_yo2NvnWQ=Lh6N1tdgZE1rA@mail.gmail.com>
MIME-Version: 1.0
Date: Tue, 11 Oct 2011 15:46:25 -0700
Message-ID: <050675599a1312d1eac8006bd908615f@mail.gmail.com>
Subject: RE: [PATCH v14 02/10] USB/ppc4xx: Add Synopsys DesignWare HS USB OTG
 driver framework
To: Kassey Lee <kassey1216@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Miesfeld <mmiesfeld@apm.com>, greg@kroah.com,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
<
<     I did  find any private info for ppc in
<     drivers/usb/dwc/apmppc.c
<
<     do you want make it generic driver ? if yes, it could be a
<generic name too.
[Tirumala Marri] This file has of PPC specific functions, like device tree
which actually contains PPC specific address ranges, interrupt numbers
etc.
--marri
