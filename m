Return-Path: <acrux_it@libero.it>
Received: from outrelay06.libero.it (outrelay06.libero.it [212.52.84.110])
 by ozlabs.org (Postfix) with ESMTP id 835DA1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 05:27:46 +1100 (EST)
Date: Wed, 30 Nov 2011 19:27:57 +0100
From: acrux <acrux_it@libero.it>
To: acrux <acrux_it@libero.it>
Subject: Re: scsi/ipr failed to initialize >=linux-3.0.9, >=linux-3.1.1
Message-Id: <20111130192757.a4d85f54.acrux_it@libero.it>
In-Reply-To: <20111127143752.269cc898.acrux_it@libero.it>
References: <20111127143752.269cc898.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 27 Nov 2011 14:37:52 +0100
acrux <acrux_it@libero.it> wrote:

> 
> scsi subsystem with ipr driver fails to initialize with every kernel >=3.0.9 and >=3.1.1
> Checked on YDL_Powerstation, IBM 9114-275, IBM 9123-710,
> 

well, it seems this was already fixed by one of these two commits (only for linux-3.2):
[SCSI] ipr: Stop reading adapter dump prematurely
commit	41e9a69641fb3fa86fa9277a179f3ad261d072f7
[SCSI] ipr: Fix BUG on adapter dump timeout
commit	4c647e909fceb9df8ec8f06016dd56244045a929

indeed YDL_Powerstation scsi ctrl has no issue with linux-3.2-rc3 .
Thus i guess also other platforms can work fine.

cheers,
--nico
-- 
acrux <acrux_it@libero.it>
