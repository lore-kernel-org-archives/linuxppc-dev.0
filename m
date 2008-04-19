Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id B2E18DE8DD
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 02:27:08 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so280923anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 09:27:07 -0700 (PDT)
Message-ID: <fa686aa40804190927u1067bd00m5734dd8b2aa84d0b@mail.gmail.com>
Date: Sat, 19 Apr 2008 10:27:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: removal of arch/ppc in 2.6.27?
In-Reply-To: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 19, 2008 at 9:30 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
> This is intended as a reminder that we plan on getting rid of arch/ppc this
> summer.  I'm guessing based on kernel release times that will be 2.6.27.
> That would mean 2.6.26 will be the last kernel to support arch/ppc.
>
>  If people have boards that like ported over please let us know and work
> with us to port this over to arch/powerpc.
>
>  Here is a list based on arch/ppc/platforms.  Its not intended to be
> complete but a general idea of what's left in arch/ppc.
>

>  LITE5200        52xx

This is in arch/powerpc

>  XILINX_ML300    40x
>  XILINX_ML403    40x

These are also supported in arch/powerpc; we just don't have .dts
files for the reference designs merged yet.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
