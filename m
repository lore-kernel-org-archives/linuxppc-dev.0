Date: Wed, 2 Oct 2002 16:02:58 +1000
From: Erik Christiansen <erik@dd.nec.com.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Is it binutils-2.13.90.0.4 or is it me?
Message-ID: <20021002060258.GD601@dd.nec.com.au>
References: <20021002010320.GA601@dd.nec.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021002010320.GA601@dd.nec.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


binutils from: ftp://ftp.kernel.org/pub/linux/devel/binutils/.
compiling with gcc 2.95.4 on debian woody.

   Oh - Oh, looks like ./config/acinclude.m4 is generating dud makefiles
in the versions: binutils-2.11.93.0.2, binutils-2.12.90.0.9, and
binutils-2.13.90.0.4. (The m4 macro substitution is broken in the same
way in each version.)

   I'll send off a bug report, but would meanwhile be grateful if some
wise soul has any hints on sourcing working ingredients for an intel/ppc
cross compiler.

Regards,
Erik


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
