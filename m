Message-ID: <3BD04DAE.761CDE75@chinook.com>
Date: Fri, 19 Oct 2001 11:58:38 -0400
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Geoff Wyche <GWyche@DATUM.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx + serial console on SCC
References: <607BF0A2B4F3D411A09500508BC225427E8328@mailctx.datum.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using it too - SCC2 in particular.

KGDB is broken.  Basic I/O worked OK with almost no work (starting from
HHL2.0) but modem control took some extra code.

Geoff Wyche wrote:
>
> Is anyone here working on an 8xx based board and using an SCC for serial
> console?
>
> I've been working on some patches for it, and would like to compare notes.
>
> The board I'm working with is a custom board that uses an 860T.  The
> particular difficulties I'm having are very much related to serial console
> IO on an SCC.  After following linuxppc-embedded for a while, it seems use
> of SCCs for serial is in the minority of configurations out there.
>
> Comments?
>
> --Geoff
> gwyche@datum.com
>

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
