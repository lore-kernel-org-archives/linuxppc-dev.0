Return-Path: <thiagogalesi@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id BD7DF679E6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 03:13:18 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so619584ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 May 2006 10:13:16 -0700 (PDT)
Message-ID: <82ecf08e0605291013t7bd1627bg92d13908b3d0b7b7@mail.gmail.com>
Date: Mon, 29 May 2006 14:13:16 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Laurent Lagrange" <lagrange@fr.oleane.com>
Subject: Re: Linux kernel thread with Linux 2.6.x
In-Reply-To: <000201c68335$7c594b90$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <000001c65d85$5e699890$5201a8c0@GEG2400>
	<000201c68335$7c594b90$5201a8c0@GEG2400>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>
> As the interrupt handler can't be scheduled, I have made a kernel thread
> which waits forever on a semaphore.
> This semaphore is set when a received packet interrupt occured.

You should look into tasklets for this. Not that your system is not
OK, but, as you said it, it's not fast enough.

Note that you still have some limitations using tasklets, but it's
more flexible than Interrupt handlers.
