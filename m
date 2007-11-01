Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 593F0DDDF7
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 10:57:40 +1100 (EST)
Date: Thu, 1 Nov 2007 18:57:28 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
Subject: Re: Module with 36K relocation entries
Message-ID: <20071101235728.GE9695@localdomain>
References: <598D5675D34BE349929AF5EDE9B03E270174CC98@az33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E270174CC98@az33exm24.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Medve Emilian-EMMEDVE1 wrote:
> 
> I have module with 36K relocation entries (I know, I know, how could
> that be...) and the count_relocs() function takes ~17 seconds to crunch
> through the relocation table from the .rela.text section. I don't think
> I can reduce the number of entries in the relocation table (can I?) so
> I'm thinking at improving the performance of count_relocs() (currently
> O(n^2)). Does anybody have a simpler idea? Does anyone have any
> constructive suggestion on how to improve the situation?

This seems to come up every few months.  There was a patch submitted
here:

http://ozlabs.org/pipermail/linuxppc-dev/2007-June/037641.html
