Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7731FB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 03:15:48 +1100 (EST)
In-Reply-To: <1259880447-5008-3-git-send-email-albert_herranz@yahoo.es>
References: <1259880447-5008-1-git-send-email-albert_herranz@yahoo.es>
	<1259880447-5008-3-git-send-email-albert_herranz@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4C1D6015-5628-4CB6-9E55-75CA20F1FB7A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 2/6] powerpc: wii: bootwrapper bits
Date: Wed, 9 Dec 2009 17:23:56 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Add support for the Nintendo Wii video game console to the powerpc
> bootwrapper.
>
> dtbImage.wii is a wrapped image that contains a flat device tree,
> an entry point compatible with the Homebrew Channel and BootMii,
> and an optional initrd.
>
> Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
