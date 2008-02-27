Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 6B6B9DDE47
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 05:20:05 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so587575anc.78
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 10:20:02 -0800 (PST)
Message-ID: <fa686aa40802271020w4ebf05b0w6745e82cb4b51107@mail.gmail.com>
Date: Wed, 27 Feb 2008 11:20:02 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [POWERPC] [v2] Xilinx: hwicap: cleanup
In-Reply-To: <20080224233457.C983D78006D@mail33-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080224232152.CEC5F12C8057@mail99-dub.bigfish.com>
	<20080224233457.C983D78006D@mail33-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev@xilinx.com, linux-kernel@vger.kernel.org,
	jirislaby@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 24, 2008 at 4:34 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
> Fix some missing __user tags and incorrect section tags.
>  Convert semaphores to mutexes.
>  Make probed_devices re-entrancy and error condition safe.
>  Fix some backwards memcpys.
>  Some other minor cleanups.
>  Use kerneldoc format.
>
>  [v2]
>  __user char => char __user
>  removed unused hwicap_command_capture
>  Fixed a comment that didn't match the function name
>  fixed argument with 'register' keyword.
>
>
>  Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Josh, can you please pick this up?

Thanks,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
