Return-Path: <glikely@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.178])
	by ozlabs.org (Postfix) with ESMTP id 50768DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Apr 2007 00:48:55 +1000 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so1577404ika
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Apr 2007 07:48:53 -0700 (PDT)
Message-ID: <528646bc0704160748o5c8ae604ma9ae70afcc649058@mail.gmail.com>
Date: Mon, 16 Apr 2007 08:48:52 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Peter Mendham" <petermendham@computing.dundee.ac.uk>
Subject: Re: Patchset to establish sanity in Xilinx Virtex support
In-Reply-To: <462337AB.5000507@computing.dundee.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <462337AB.5000507@computing.dundee.ac.uk>
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

On 4/16/07, Peter Mendham <petermendham@computing.dundee.ac.uk> wrote:
> I have applied your patches to a 2.6.20.4 kernel, along with your
> SystemACE driver. I am fully up and running on a simple ML405-based
> system setup with a Uartlite and a SystemACE. (I made the Kconfig
> changes suggested by Dale Farnsworth to my copy). So, thank you very
> much. I appreciate the neatness of your patches, the fact that I now
> have early boot text support on my uartlite port and the fact that
> (somehow) you've shaved a good couple of seconds of my boot time against
> the Xilinx SystemACE driver. Thanks!

Thanks for your feedback.

I'm glad to hear that the driver is faster; I was hoping that was the
case, but I haven't benchmarked it against the Xilinx driver yet.
Please,
please, PLEASE let me know if you have any problems with it.  Any
information you can provide me on your usage would be fantastic.

So, I assume that your rootfs is mounted from the CF card, correct?
If so, very cool.  I hadn't gotten to that point in my testing, so I
didn't know if that would work.  :-)

> In your reply to Mohamed Sadegh Sadri you mentioned that you will be
> publishing your GIT tree with TEMAC support.  Two very quick questions:
> where do I find this, and does it support auto-negotiation properly?  I
> am having serious problems with auto-negotiation and the various
> flavours of driver out there.  It seems like the best long term plan
> would be to use the PHYLIB support to handle the PHY side of things but
> I have only just started looking into this.

I'll be posting it on my git server at http://git.secretlab.ca, and
yes it does support autonegotiation, at least when using the Phy that
is on the ML403 board.  I'm going to take a close look a the TEMAC
patch that Andrei recently posted on the list which makes use of phylib.  It
looks interesting.

Cheers and thanks,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
