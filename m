Message-ID: <3BE972F6.5CAEF36@mvista.com>
Date: Wed, 07 Nov 2001 10:44:22 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: The Plan
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> This is what I am thinking of; I have implemented it locally here and
> I'm doing test compiles with arch/ppc/configs/*.
>
> - arch/ppc/kernel/ppc_asm.h moves to include/asm-ppc, and the contents
>   of ppc_asm.tmpl get folded into it, with corresponding changes to
>   arch/ppc/*/*.S.
>
> - Files which relate only to one platform, or a small number of
>   platforms, move to arch/ppc/platforms.  (There are some minor
>   exceptions to this rule which we can discuss if people are
>   concerned.)  We end up with:

I like this too.  Seems like a good compromise between one dir with a
bunch of files and a bunch of dirs each with a couple files.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
