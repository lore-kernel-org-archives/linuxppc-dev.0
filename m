Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CE1E1A105D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 01:38:46 +1100 (AEDT)
Date: Mon, 16 Feb 2015 08:37:06 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v1 2/7] AES for PPC/SPE - aes tables
Message-ID: <20150216143706.GA3609@gate.crashing.org>
References: <cfb098e9-69ae-47ff-afa7-08c922accd31@EXCHANGE.collogia.de>
 <063D6719AE5E284EB5DD2968C1650D6D1CAE46B2@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CAE46B2@AcuExch.aculab.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 'Markus Stockhausen' <stockhausen@collogia.de>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 16, 2015 at 02:19:50PM +0000, David Laight wrote:
> From:  Markus Stockhausen
> > 4K AES tables for big endian
> 
> I can't help feeling that you could give more information about how the
> values are generated.

... and an explanation of why this does not open you up to a timing attack?


Segher
