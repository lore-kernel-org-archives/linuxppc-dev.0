Message-ID: <3CFD3893.9ECC91D4@mvista.com>
Date: Tue, 04 Jun 2002 15:00:51 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@motorola.com>
Cc: Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: pt_regs.dbcr0/1
References: <D68E7052-7802-11D6-B64C-003065BFB10E@motorola.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kumar Gala wrote:
>
> I am not seeing where the other debug registers that are associated with
> the debug state are being state changed and managed.  For example
> IAC{1-4} [breakpnt], DACs [watchpnts], DVCs are being handled.

The current kernel does not take advantage (use) the hardware breakpoint
and watchpoint registers.  Current jtag based debuggers are capable of
using these registers.  It would be extremely useful to add support
of these resources.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
