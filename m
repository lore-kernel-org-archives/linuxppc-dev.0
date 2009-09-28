Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id DB0ADB7BED
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Sep 2009 15:36:57 +1000 (EST)
Date: Mon, 28 Sep 2009 01:36:54 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: warning: allocated section `.data_nosave'  not in segment
Message-ID: <20090928013654.466c9b72@opus.seanm.ca>
In-Reply-To: <20090925165411.6c584401@lappy.seanm.ca>
References: <20090925165411.6c584401@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If I revert the commit show at the bottom of this email, the warnings
go away.

It took a while to find this, git bisect kept pointing me to a file
from arch/alpha :(

Cheers,
   Sean


powerpc: Cleanup linker script using new linker script macros.



author	Tim Abbott <tabbott@ksplice.com>

	 Thu, 24 Sep 2009 14:36:24 +0000 (10:36 -0400)

committer	Linus Torvalds <torvalds@linux-foundation.org>

	 Fri, 25 Sep 2009 00:16:22 +0000 (17:16 -0700)

commit	62bef288588bee976b753f7168716621d7a984e2

tree	8f55ea7fc2c5d651b72d1addad5687d61b857910	tree |
snapshot

parent	4a5e35135d1ffcf14ebb2bb3c730b92c18ae9657	commit |
diff



powerpc: Cleanup linker script using new linker script macros.



Signed-off-by: Tim Abbott <tabbott@ksplice.com>

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cc: Paul Mackerras <paulus@samba.org>

Cc: linuxppc-dev@ozlabs.org

Acked-by: Sam Ravnborg <sam@ravnborg.org>

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
