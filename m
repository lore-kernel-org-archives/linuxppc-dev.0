Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97699DE0E9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 06:20:32 +1100 (EST)
Date: Wed, 11 Mar 2009 12:18:32 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
In-Reply-To: <alpine.LRH.2.00.0903111652070.1040@vixen.sonytel.be>
Message-ID: <alpine.LFD.2.00.0903111217320.32478@localhost.localdomain>
References: <1236729444.7086.24.camel@pasglop>
	<alpine.LRH.2.00.0903111028480.1040@vixen.sonytel.be>
	<1236769025.7086.46.camel@pasglop>
	<alpine.LFD.2.00.0903110835020.32478@localhost.localdomain>
	<alpine.LRH.2.00.0903111652070.1040@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Wed, 11 Mar 2009, Geert Uytterhoeven wrote:
> 
> Are you aware the old one was introduced in 2.6.29-rc1? So there cannot be a
> regression from 2.6.28 or older.

Ahh, no, that part hadn't registered.

In that case, I guess I don't really care, as long as everybody involved 
feels it's clearly better than the one merged into -rc1.

		Linus
