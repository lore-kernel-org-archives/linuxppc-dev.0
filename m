Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id BF87EDDE9D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 08:15:57 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so344006anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 27 Jan 2008 13:15:56 -0800 (PST)
Message-ID: <fa686aa40801271315m5ba4ea08p913fd6235eb1d240@mail.gmail.com>
Date: Sun, 27 Jan 2008 14:15:56 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Ricardo Severo" <severo.ricardo@gmail.com>
Subject: Re: Linux boot on a ppc 405
In-Reply-To: <479CAF56.30306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <479CAF56.30306@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/27/08, Ricardo Severo <severo.ricardo@gmail.com> wrote:
> Hi all,
>
> I am working with a Xilinx Virtex II Pro  evaluation board, wich has two
> PowerPC 405 and I'm trying to boot a vanilla linux kernel 2.6.23.14.
> Until now I've manged to make it uncompress the kernel, but it doesn't boot.
> My question is how the initial execution (the one who uncompresses the
> kernel image) transfers the processor to the kernel itself. I've looked
> in the arch/ppc/boot/simple/relocate.S code and it jumps to the position
> 0x0 after uncompressing, is it right? The kernel is uncompressed at that
> position?

Post your output log please.

If your getting a message that the kernel is uncompressing, but you
don't have any output beyond that then most likely your console is not
setup correctly.  If you've got a debugger, look at memory at the
__log_buf location to see if there are any boot logs there.

Cheers,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
