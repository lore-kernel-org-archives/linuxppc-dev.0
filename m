Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id 1C5A1DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 13:55:13 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so398767anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Apr 2008 20:55:12 -0700 (PDT)
Message-ID: <fa686aa40804072055i1f7036afn4d453e968cc625d6@mail.gmail.com>
Date: Mon, 7 Apr 2008 21:55:12 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
Subject: Re: Booting a Xilinx board
In-Reply-To: <10a101c898c4$c183ee40$f52f9e86@LPSC0173W>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <10a101c898c4$c183ee40$f52f9e86@LPSC0173W>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 7, 2008 at 9:33 AM, Guillaume Dargaud <dargaud@lpsc.in2p3.fr> wrote:
>
>  Linux/PPC load: console=ttyS0,9600 ip=on root=/dev/sysace/disc0/part2 rw
>  Uncompressing Linux...done.
>  Now booting the kernel
>
>  And then it stops.
>  I'm sure I've overlooked something obvious...

Are you using uartlite?  Try console=ttyUL0.

But Stephen is right, the first thing you should do is look at
__log_buf.  You can find its address in the System.map file.

Cheers,
g.
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
