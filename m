Subject: Re: clarification to _GLOBAL declaration in processor.h!!!
From: Gary Thomas <gary@mlbassoc.com>
To: Anand Franklin J <franklin@innomedia.soft.net>
Cc: ppc_embedded_maillist <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <3E420C30.D22A30C4@innomedia.soft.net>
References: <3E420C30.D22A30C4@innomedia.soft.net>
Content-Type: text/plain
Date: 06 Feb 2003 06:45:11 -0700
Message-Id: <1044539111.3119.886.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2003-02-06 at 00:18, Anand Franklin J wrote:
>
> Hi,
>         I am compiling a asembler code but it gives the following error,
> using the asembler (MVL ppc_405-as)
>
> ppc_call.s:4000: Error: Unrecognized opcode:
> `_global(powerpcMfhsmc1_data)'
> ppc_call.s:4017: Error: Unrecognized opcode: `_global(setgpio_bit)'
> ppc_call.s:4084: Error: Unrecognized opcode: `_global(np_compare_swap)'
>
> how to solve this problem.

Check the documentation.  These expressions should be written:

	.globl	powerpcMfhsmc1_data
etc.

--
------------------------------------------------------------
Gary Thomas                 |
MLB Associates              |  Consulting for the
+1 (970) 229-1963           |    Embedded world
http://www.mlbassoc.com/    |
email: <gary@mlbassoc.com>  |
gpg: http://www.chez-thomas.org/gary/gpg_key.asc
------------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
