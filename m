Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id 84942DDDF5
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 08:45:30 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1402376rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 15:45:29 -0700 (PDT)
Date: Mon, 30 Jun 2008 16:45:27 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Message-ID: <20080630224526.GA23679@secretlab.ca>
References: <20080630142451.516A41D1006C@mail57-sin.bigfish.com>
	<20080630171628.GF17916@secretlab.ca>
	<20080630200015.06E6E1F8054@mail93-va3.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080630200015.06E6E1F8054@mail93-va3.bigfish.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, Sadanand Mutyala <sadanan@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 30, 2008 at 02:00:12PM -0600, John Linn wrote:
> >
> >Since xps2_recv() and xps2_send() are used by the sxps2_* routines and
> >by the irq handler, they should be moved to about them in this file.
> >
> 
> OK, keeping them close makes maintenance easier I guess.
> 

Oops, there is a typo in my comment:

"... they should be moved to *above* them in this file."  'about' doesn't
make much sense.

g.
