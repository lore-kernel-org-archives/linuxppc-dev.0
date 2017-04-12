Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2m7G0V0yzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 11:10:18 +1000 (AEST)
Date: Wed, 12 Apr 2017 11:10:17 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Oliver O'Halloran <oohall@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, arbab@linux.vnet.ibm.com,
 linux-nvdimm@lists.01.org
Subject: Re: ZONE_DEVICE and pmem API support for powerpc
Message-ID: <20170412111017.0b94b80b@canb.auug.org.au>
In-Reply-To: <20170411174233.21902-1-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Oliver,

On Wed, 12 Apr 2017 03:42:24 +1000 Oliver O'Halloran <oohall@gmail.com> wrote:
>
> Series is based on next-20170411, but it should apply elsewhere with minor
> fixups to arch_{add|remove}_memory due to conflicts with HMM.  For those

Just to make life fun for you, Andrew has dropped the HMM patches from
his quilt series today (and so they will not be in next-20170412).

-- 
Cheers,
Stephen Rothwell
