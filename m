Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id 7ED35DDFA4
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 01:54:36 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5342975wag
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 08:54:35 -0700 (PDT)
Message-ID: <fa686aa40710020854n2dd73d07h85d43373ac382bf1@mail.gmail.com>
Date: Tue, 2 Oct 2007 09:54:34 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH 06/18] [POWERPC] Fix UARTLITE reg io for little-endian
	architectures (ie. microblaze)
In-Reply-To: <87abr134pc.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
	<20070928181704.18608.40317.stgit@trillian.cg.shawcable.net>
	<87abr134pc.fsf@macbook.be.48ers.dk>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> The uartlite driver is ofcause primarily used to drive Xilinx
> OPB_Uartlite IP blocks, but that's not the only use - E.G. we are
> using another simple UART with the same hardware interface but sitting
> on a 16bit bus. With the current driver this works fine, but won't
> with the out_be32.

Ugh.  Alright I'll revert the patch.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
