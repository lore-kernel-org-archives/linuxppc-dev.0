Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id C4580DDFDF
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 00:01:27 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so512916wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 07:01:26 -0700 (PDT)
Date: Fri, 19 Sep 2008 07:49:34 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: =?us-ascii?B?PT9JU08tODg1OS0xP1E/Uz1FOWJhc3RpZW5fQ2hyPUU5dGllbl8=?=
	<sebasti?==?ISO-8859-1?Q?en.chretien.enseirb@gmail.com>, ?=@secretlab.ca
Subject: Re: ioremap and vmalloc
Message-ID: <20080919134933.GA7849@secretlab.ca>
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 19, 2008 at 01:15:20PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
> Hello,
> 
> When I use ioremap, the second time, I obtain this message :
> 
> allocation failed: out of vmalloc space - use vmalloc=<size> to increase
> size.
> What can I do in order to fix this problem ?

How large are the regions that you are ioremapping?  The kernel sets
aside a fixed amount of the virtual address space for ioremaps, and if
you exhaust that then more ioremaps will stop working.

g.
