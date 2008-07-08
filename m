Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.247])
	by ozlabs.org (Postfix) with ESMTP id 4181DDDEEF
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 00:19:03 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so640491hsz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jul 2008 07:19:00 -0700 (PDT)
Message-ID: <fa686aa40807080719r4b7b01f7n7863fe1456a3e64@mail.gmail.com>
Date: Tue, 8 Jul 2008 08:19:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paolo Doz" <paolo.doz@gmail.com>
Subject: Re: While(1) in kernel space
In-Reply-To: <5468b7f30807080055p69571979i9a565653e523c2c0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <5468b7f30807080055p69571979i9a565653e523c2c0@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 8, 2008 at 1:55 AM, Paolo Doz <paolo.doz@gmail.com> wrote:
> Hi folks,
> I'm developing a custom SPI driver (char device) on a MPC5200b, the
> microcontroller linked as slave implements a protocol that must follow
> strict timing constraints. I need to receive and send messages every 6msec.
> Actually there is a user space program that synchronizes the two units, but
> I would prefer to eliminate it and move the relative code into the kernel
> space. Is it possible to have a non returning function, with a sort of
> while(1) inside?
>
> Thanks for the help

You can use a kernel thread.

I'm not sure how accurate this is, but here is some information about them:

http://www.linuxquestions.org/linux/articles/Technical/Linux_Kernel_Thread
