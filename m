Date: Fri, 8 Mar 2002 15:54:37 -0500
Subject: some issues with dual G4 1Gig machines
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v481)
Cc: yellowdog-devel@lists.yellowdoglinux.com
To: linuxppc-dev@lists.linuxppc.org
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Message-Id: <B3C17D88-32D6-11D6-815C-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have been using a modified version of Ben's kernel (modified to
recognize the 7455's and built to support smp (but NOT to distribute
irqs to all processors).

Basically this machine has been rock steady and I have gone days (weeks)
without rebooting it into Mac OSX (I realize that is no a long time but
I just got the machine in early Feb).

However the last time I tried to shut it down I received the following
error message:

/sbin/shutdown -h now
...
The system is halted.

smp_call_function on cpu 0: other cpus not responding (0)

Serial port locked ON by debugger!

wait_on_irq, CPU 0:
irq: 1 [0 1]
bh: 0 [0 0]

And it hangs here waiting and it never shuts down the machine.

Are there any known races or problems in the shutdown and halting
sequence for smp machines?  My guess is this sequence is not overly
tested!

Also I seem to error messages about duplicate ticks (an smp issue?) and
my clock loses something like 5 minutes a day (basically running
unloaded most of the time).

Are either of these known issues?

Ideas welcome?

Are all the required changes in your latest tree and should I just grab
it.

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
