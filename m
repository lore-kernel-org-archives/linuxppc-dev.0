Return-Path: <lars@metafoo.de>
Received: from smtp-out-076.synserver.de (smtp-out-076.synserver.de
 [212.40.185.76]) by ozlabs.org (Postfix) with ESMTP id B1BDA2C0362
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 02:51:05 +1000 (EST)
Message-ID: <51E03290.7070806@metafoo.de>
Date: Fri, 12 Jul 2013 18:45:04 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH RFC 0/8] MPC512x DMA slave s/g support, OF DMA lookup
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
In-Reply-To: <1373642781-32631-1-git-send-email-gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 devicetree-discuss@lists.ozlabs.org, Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/2013 05:26 PM, Gerhard Sittig wrote:
[...]
> Lars, there is a checkpatch warning about a line longer than 80
> characters in the common xlate part -- I didn't dare to change your
> submission, and the part included here is verbatim from your patchwork
> 2331091 (original submission) and 2555701 (resend), is there a followup
> which you can provide or point us to?

Well the line is 81 characters long, so I wouldn't worry to much about that.
But we should probably remove the extern from all the function declarations
in dma-of.h, since the extern is kind of implicit for functions declarations.

- Lars
