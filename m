Return-Path: <daniel.ng1234@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.229])
	by ozlabs.org (Postfix) with ESMTP id A7070DE202
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 17:47:39 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f9so691251rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 00:47:37 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 17 Apr 2009 17:47:37 +1000
Message-ID: <547eba1b0904170047ob37e918j74db791442a0b1f6@mail.gmail.com>
Subject: PPP over Synchronous HDLC in the Linux Kernel
From: Daniel Ng <daniel.ng1234@gmail.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Is there a way to integrate PPP over Synchronous HDLC using the
existing kernel code? We are currently using 2.6.27 on an 8272 ppc
board.

In the past, we have had this working on 2.6.14 by porting across Dan
Eble's PPC kernel patches, detailed below.

However, it seems these patches were never integrated into the kernel main line.

So, is it possible to implement PPP over Synchronous HDLC using the
current kernel code, without having to use these patches?

Cheers,
Daniel


Dan Eble's "Generic PPP for Generic HDLC" patches originally for a
2.4.21 kernel (PPC).

Patch details found at:

Kernel patches:

http://marc.theaimsgroup.com/?l=linux-net&m=105525978800615&w=2
http://marc.theaimsgroup.com/?l=linux-net&m=105526005200965&w=2
http://marc.theaimsgroup.com/?l=linux-net&m=105526034801396&w=2

PPP daemon patches:

http://marc.theaimsgroup.com/?l=linux-ppp&m=105526128502635&w=2
http://marc.theaimsgroup.com/?l=linux-ppp&m=105613926625787&w=2
