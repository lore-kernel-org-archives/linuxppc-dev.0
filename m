Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 0CAABDDFF5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 06:36:35 +1000 (EST)
Date: Fri, 15 Jun 2007 15:44:22 -0500
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] [POWERPC] Add cputable entry for PowerPC 440SPe Rev. B
Message-ID: <20070615204422.GA4617@lixom.net>
References: <18034.6787.951861.623265@cargo.ozlabs.ibm.com>
	<adawsy5ggcf.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adawsy5ggcf.fsf@cisco.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, Jun 15, 2007 at 12:36:32PM -0700, Roland Dreier wrote:
> When adding the cputable entry for 440SPe Rev. B, we also need to
> adjust the existing entries for 440SP Rev. A and 440SPe Rev. B so that
> they look more bits of the PVR.  The 440SPe Rev. B has PVR 53421891,
> which would match the current 440SP Rev. A pattern of 53xxx891.  To
> distinguish between 440SP and 440SPe, we need to use the first three
> digits of the PVR, which are respectively 532 and 534.

I can see why you need to distinguish between 440SP and SPe, but do you
really need separate cputable entries for rev A and B? Revisions are
normally reported separately and the cputable entries look identical?


-Olof
