Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id ABB51DE47B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 03:55:52 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so519205nfd.9
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 10:55:50 -0700 (PDT)
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: Added new XPS PS2 driver
References: <20080630153824.ED3D319B0075@mail96-wa4.bigfish.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 30 Jun 2008 19:55:48 +0200
In-Reply-To: <20080630153824.ED3D319B0075@mail96-wa4.bigfish.com> (John Linn's
	message of "Mon\, 30 Jun 2008 08\:38\:21 -0700")
Message-ID: <877ic6dcyj.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Sadanand <sadanan@xilinx.com>,
	linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "John" == John Linn <john.linn@xilinx.com> writes:

 John> Added a new driver for Xilinx XPS PS2 IP. This driver is
 John> a flat driver to better match the Linux driver pattern.

 John> Signed-off-by: Sadanand <sadanan@xilinx.com>
 John> Signed-off-by: John Linn <john.linn@xilinx.com>
 John> ---

 John> V2

 John> Changes from v1:

 John> Ran the scripts/checkpatch.pl on the patch as I should have done
 John> before sending it (thanks to Stephen).

What about my comments?

-- 
Bye, Peter Korsgaard
