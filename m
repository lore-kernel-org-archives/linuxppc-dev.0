Message-ID: <3C07E073.9020208@embeddededge.com>
Date: Fri, 30 Nov 2001 14:39:31 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Armin Kuster <akuster@mvista.com>
Cc: ppclist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 4xx & Abatron
References: <3C07EB05.8C598E53@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Armin Kuster wrote:

> Has anyone tried using the Abatron w/ the latest ppc kernel on 4xx?
>  I am not sure I there is a kernel issue or if my h/w is acting up.

We screwed up Abatron by moving bits around in the kernel PTE, so
you have to be patient with them and find a version of the 4xx BDI2000
firmware that matches your kernel.  The latest kernels and latest
firmware do work.

Sorry about that.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
