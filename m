In-Reply-To: <38EB6A36.1A8D24C1@erols.com>
Date: Wed, 5 Apr 2000 19:01:31 +0200
To: Nelson Abramson <pogtal@erols.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: XFree 4 & sound problems
Message-Id: <20000405190131.025451@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Apr 5, 2000, Nelson Abramson <pogtal@erols.com> wrote:

>> If I just let things go and don't touch anything, it plays fine. The
>> freeze requires a reset button reboot--the machine is not reachable at
>> all (i.e. it's not just X).
>
>Could you maybe check what parameters you have enabled on your disk via
>hdparm?  I have had a few hard freezes, and I think they are related to a
>small bug in either multiword dma or irq masking.  If I have those options
>enabled, I occasionally get a machine freeze, caused by xmms (once by
>slocate via cron)...(that's what the xmon debugger says anyways)

That's really interesting since there is no bug I know of. Can you please
tell me:

  - The exact machine model
  - Did the problem began with a specific kernel or did you always had it
  - Do you use the "nap" mode for power management ? (assuming it's a
powerbook)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
