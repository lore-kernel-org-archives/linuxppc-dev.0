Return-Path: <timur.tabi@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 63F91DDE1F
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 12:44:52 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so192736qwe.15
	for <linuxppc-dev@ozlabs.org>; Thu, 05 Mar 2009 17:44:50 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <49B06197.8010007@freescale.com>
References: <1236295403-11954-1-git-send-email-timur@freescale.com>
	<49B06197.8010007@freescale.com>
Date: Thu, 5 Mar 2009 19:44:50 -0600
Message-ID: <ed82fe3e0903051744u1454b842pd1a0c90c016aa9c2@mail.gmail.com>
Subject: Re: [PATCH] powerpc: clean up ssi.txt, add definition for fsl,
	ssi-asynchronous
From: Timur Tabi <timur@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 5, 2009 at 5:34 PM, Scott Wood <scottwood@freescale.com> wrote:

> Does the above mean "SRCK, STCK, SRFS, and STFS must all be connected to the
> same clock", or does it mean "SRCK must be connected to the same clock as
> STCK, and SRFS must be connected to the same clock as STFS"?

The latter.  I'll reword it.

-- 
Timur Tabi
Linux kernel developer at Freescale
