Return-Path: <v.selvamuthukumar@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id 774A5DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 20:01:01 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so489941qwb.15
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Oct 2008 02:00:59 -0700 (PDT)
Message-ID: <790896390810170200v110886lffddc5d4b94592a2@mail.gmail.com>
Date: Fri, 17 Oct 2008 14:30:59 +0530
From: "selvamuthukumar v" <v.selvamuthukumar@gmail.com>
To: "Juan Antonio Medina Guerrero" <juan-antonio.medina@anafocus.com>
Subject: Re: Trying to free IRQ
In-Reply-To: <1D4F7D951F69470B8F338C8DF3A212C9@svq.anafocus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1D4F7D951F69470B8F338C8DF3A212C9@svq.anafocus.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2008 at 1:45 PM, Juan Antonio Medina Guerrero
<juan-antonio.medina@anafocus.com> wrote:
>       if (request_irq(irq_id, interrupt_handler, 0, "MYMODULE", &dev_id))
<snip>
>       free_irq(irq_id,NULL);
>

This should be free_irq(irq_id, &dev_id);

-- 
Selva
