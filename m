Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1D24DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 02:12:57 +1100 (EST)
Message-Id: <51DE5987-D0DD-4E62-A99A-3D23ECFA9908@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071130141540.GA3117@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 0/24] powerpc: 4xx PCI,
	PCI-X and PCI-Express support among others
Date: Fri, 30 Nov 2007 09:12:34 -0600
References: <1196403038.569525.367459803520.qpush@grosgo>
	<20071130141540.GA3117@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 30, 2007, at 8:15 AM, Olof Johansson wrote:

> On Fri, Nov 30, 2007 at 05:10:38PM +1100, Benjamin Herrenschmidt  
> wrote:
>
>> There will be further cleanups and fixes before 2.6.25 opens
>
> May I suggest running them through checkpatch.pl? It finds stuff in  
> over
> half of the ones I tried it on :)

You know of anyone that's integrated checkpatch.pl w/a git commit or  
git-add? (effective run checkpatch.pl on the index before you commit  
it).

- k
