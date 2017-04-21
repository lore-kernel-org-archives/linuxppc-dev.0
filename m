Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8fGG5j4LzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 01:06:46 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/7] powerpc: kprobes: use safer string functions in
 kprobe_lookup_name()
Date: Fri, 21 Apr 2017 15:06:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFD7B52@AcuExch.aculab.com>
References: <cover.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
 <d8a1de28324a2350483a961be078a6343111632b.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <d8a1de28324a2350483a961be078a6343111632b.1492604782.git.naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Naveen N. Rao
> Sent: 19 April 2017 13:51
...
>  			dot_name[0] =3D '\0';
> -			strncat(dot_name, name, sizeof(dot_name) - 1);
> +			strlcat(dot_name, name, sizeof(dot_name));
...

Is that really zeroing the first byte just so it can append to it?

	David
