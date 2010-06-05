Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id CC8C4B7D43
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jun 2010 03:38:53 +1000 (EST)
Date: Sat, 5 Jun 2010 13:32:10 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] [powerpc] do not expect executable permissions for
	in-tree shell scripts
Message-ID: <20100605133210.11f504c3@opus.seanm.ca>
In-Reply-To: <20100605081039.GA21300@aepfle.de>
References: <20100605081039.GA21300@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 5 Jun 2010 10:10:39 +0200
Olaf Hering <olaf@aepfle.de> wrote:

> scripts in the kernel source do not have executable permissions if
> they were created with patch(1) run mkuboot.sh with bash, its tagged
> as bash script.

Wouldn't it be better to use ${SHELL}? Not every system has bash.

Cheers,
   Sean
