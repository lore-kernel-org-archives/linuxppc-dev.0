Date: Tue, 10 Jun 2003 10:02:09 -0500
Subject: Re: init does not run on 405GP system
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Robert Schwebel <robert@schwebel.de>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <20030610141047.GU9379@pengutronix.de>
Message-Id: <8263E99D-9B54-11D7-8E3D-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday, Jun 10, 2003, at 09:10 US/Central, Robert Schwebel wrote:
>
> I'm currently porting u-boot and Linux to an IBM 405GP based board. The
> problem is now that init seems not to be running and does not give any
> output. Up to that point where init should make some noise the kernel
> boots smoothly (serial console), I see all output and NFS-Root is
> mounted via an Intel 82559 network chip. The kernel threads are also
> running, I see kupdated & friends being put into the run queue from
> time
> to time.

That's where I've seen output stop when I've forgotten to put a getty
on /dev/ttyS0 in /etc/inittab...

--
Hollis Blanchard
IBM Linux Technology Center


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
