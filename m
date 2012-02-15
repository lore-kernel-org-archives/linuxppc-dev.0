Return-Path: <bauerman@br.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp01.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 02CFB1007D4
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Feb 2012 09:19:02 +1100 (EST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <bauerman@br.ibm.com>;
 Wed, 15 Feb 2012 20:18:57 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id D6912352004A
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2012 20:18:54 -0200 (BRST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1FMIshZ25428068
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2012 20:18:54 -0200
Received: from d24av03.br.ibm.com (loopback [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1FKJ8WZ016824
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2012 18:19:08 -0200
Message-ID: <1329344331.10157.22.camel@hactar>
Subject: Re: [PATCH 2/2] [PowerPC Book3E] Introduce new ptrace debug feature
 flag
From: Thiago Jung Bauermann <bauerman@br.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Date: Wed, 15 Feb 2012 20:18:51 -0200
In-Reply-To: <20120116081833.GG4512@truffala.fritz.box>
References: <20111208111212.GB3720@in.ibm.com>
 <20111208112330.GB24484@in.ibm.com>
 <20111221005502.GE5188@truffala.fritz.box>
 <20111222093447.GD26407@in.ibm.com>
 <20120116081833.GG4512@truffala.fritz.box>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>,
 Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-01-16 at 19:18 +1100, David Gibson wrote:
> Hrm.  An EXACT breakpoint is not exactly the same as a range
> breakpoint of length 1 (consider unaligned accesses).  But despite
> that, it should be possible to implement exact breakpoints on Book3S
> server hardware with some software filtering.
> 
> And since that leaves no hardware that *can't* implement exact
> breakpoints (directly or indirectly), I'm not yet convinced of the
> need for a flag bit.

I agree.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
