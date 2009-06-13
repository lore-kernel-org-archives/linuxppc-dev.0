Return-Path: <torvalds@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3DB40B70CE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 14 Jun 2009 06:14:15 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ABD99DDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jun 2009 06:14:14 +1000 (EST)
Date: Sat, 13 Jun 2009 13:13:38 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/2] lib: Provide generic atomic64_t implementation
In-Reply-To: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
Message-ID: <alpine.LFD.2.01.0906131312470.3237@localhost.localdomain>
References: <18995.20685.227683.561827@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sat, 13 Jun 2009, Paul Mackerras wrote:
>
> Linus, Andrew: OK if this goes in via the powerpc tree?

Ok by me.

		Linus
