Message-ID: <20030908223649.948.qmail@web40905.mail.yahoo.com>
Date: Mon, 8 Sep 2003 15:36:49 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: virt_to_phys() on 440
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20030908151459.A16761@home.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> These APIs are valid only for
> system
> memory kernel addresses that are staticly mapped.
>
> Anything wanting a generic translation from
> virt->phys should
> call iopa() directly until somebody drives a generic
> translation
> API into the kernel.

Thanks, I missed that.

Regards,
Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
