Date: Wed, 3 Sep 2003 18:54:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Yuxiao Xi <xiyuxiao@harbournetworks.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: DINK32 R13.1 on Sandpoint X2
Message-ID: <20030904015430.GA20060@ip68-0-152-218.tc.ph.cox.net>
References: <200309040129.UAA29736@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309040129.UAA29736@gate.crashing.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 04, 2003 at 09:37:40AM +0800, Yuxiao Xi wrote:

> Hi,Tom,
>      From the mailing lists,I know that someone use DINK32's tftp download function
> to download his image successfully on a Sandpoint X3 board.Is there any important
> differences between Sandpoint X3 and X2 board so that I can not use the DINK32's tftp
> function on X2 board?

I do not know, as I don't have the proper ethernet card.  I do know
however, that I don't really care to find one now as I can upload a
kernel quick enough via serial that it doesn't really slow me down.
And, while not related to your problem, tftp isn't supported on 75x
CPUs, which is what I have at the moment.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
