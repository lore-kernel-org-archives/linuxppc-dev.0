Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 0FF2EDDF0E
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 16:35:47 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so30419ugf.0
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 23:35:45 -0700 (PDT)
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: driver updates based on review
References: <20080710193451.ED2B51D18066@mail97-dub.bigfish.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Fri, 11 Jul 2008 08:35:41 +0200
In-Reply-To: <20080710193451.ED2B51D18066@mail97-dub.bigfish.com> (John Linn's
	message of "Thu\, 10 Jul 2008 12\:34\:43 -0700")
Message-ID: <871w21lygy.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: Sadanand <sadanan@xilinx.com>, dmitry.torokhov@gmail.com,
	linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "John" == John Linn <john.linn@xilinx.com> writes:

 John> Review comments were incorporated to improve the driver.
 John> 1. Some data was eliminated that was not needed.
 John> 2. Renaming of variables for clarity.
 John> 3. Removed unneeded type casting.
 John> 4. Changed to use dev_err rather than other I/O.
 John> 5. Merged together some functions.
 John> 6. Added kerneldoc format to functions.

 John> Signed-off-by: Sadanand <sadanan@xilinx.com>
 John> Signed-off-by: John Linn <john.linn@xilinx.com>

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
