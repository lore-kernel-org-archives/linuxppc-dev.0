Message-Id: <200001060820.DAA00836@SICP-24.MIT.EDU>
To: Joseph Garcia <jpgarcia@execpc.com>
Cc: Naoki Takebayashi <ntakebay@bio.indiana.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: enhanced RTC and SMP on PowerMac 
In-Reply-To: Your message of "Wed, 05 Jan 2000 16:31:55 CST."
             <3873C65B.54932D84@execpc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jan 2000 03:20:44 EST
From: "Charles E. Leiserson, Jr." <locutus@MIT.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Is enhanced RTC supposed to work on PowerMac?  When I compile with
> > CONFIG_RTC, the kernel doesn't boot up and dies when it hits the following
> > line:
> > 
> >    /* Initialize periodic freq. to CMOS reset default, which is 1024Hz */
> >    CMOS_WRITE(((CMOS_READ(RTC_FREQ_SELECT) & 0xF0) | 0x06), RTC_FREQ_SELECT);
> 
> I have the same problem.  I dont think it should work.  (CMOS on a ppc?)
> 
> I have noticed that the 'clock' program seems to access the rtc.  Assuming it
> is, it may have the code we want to put in the kernel.

Don't use the RTC option.  That's only for x86.  Also, SMP appears to be broken on 2.2.14.


					- Ricky


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
