Subject: Re: Guidance Request Regarding openpic_hookup_cascade()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Randy Vinson <rvinson@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
In-Reply-To: <40898231.20002@mvista.com>
References: <40898231.20002@mvista.com>
Content-Type: text/plain
Message-Id: <1082769227.6442.40.camel@gaston>
Mime-Version: 1.0
Date: Sat, 24 Apr 2004 11:13:48 +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, 2004-04-24 at 06:53, Randy Vinson wrote:
>
>   In updating some of the boards for 2.6, I've encountered one
> without an 8259. I can either stub-out the call to i8359_irq() in
> my board-specific code or pull the openpic_hookup_cascade() support
> forward from 2.4. I've been told that the cascade approach is no
> longer in favor, but I have not been able to locate an alternative.
> So, does anyone have a recommendation on how to proceed?

Yes, we wanted to do better but never found the time to do so. I
suppose pulling the 2.4 approach in 2.6 is the best solution at this
point.

Ben

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
