Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by lists.ozlabs.org (Postfix) with ESMTP id 3z1Rs41PF8zF07c
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 05:54:15 +1100 (AEDT)
Date: Tue, 19 Dec 2017 19:54:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Joe Perches <joe@perches.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
 linux-wimax@intel.com, James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, Zhang Rui <rui.zhang@intel.com>,
 Eduardo Valentin <edubezval@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [-next PATCH 4/4] treewide: Use DEVICE_ATTR_WO
Message-ID: <20171219185407.fdrcmrjbmzmhl72w@pd.tnic>
References: <cover.1513706701.git.joe@perches.com>
 <fa30f1ad73f76dafff816df40cacffe613aa2f48.1513706702.git.joe@perches.com>
 <20171219184441.ixxh757tl44qvk5l@pd.tnic>
 <1513709474.1234.66.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1513709474.1234.66.camel@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 19, 2017 at 10:51:14AM -0800, Joe Perches wrote:
> > The reason for the code churn being?
> 
> Consistency for easier grep by use-type.

Please explain that in the commit message so that we know why it was
changed.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
