Content-Type: text/plain;
  charset="us-ascii"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.19 on dual 1gig G4 funny slow down to kernel death experience
Date: Fri, 7 Feb 2003 16:29:28 -0500
MIME-Version: 1.0
Message-Id: <200302071629.28657.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just experienced the funny slow down until kernel death experience again
that I reported many months ago on my dual 1gig G4 machine (smp with 768
meg of memory)

The dmesg log is full of a long stream of the following

wait_on_irq, CPU 0:
irq:  -1 [0 0]
bh:   0 [0 0]

Everything got slower and slower (I could actually watch the sequence of
events that happen when an icon is clicked!)

And processing would only continue if I hit <enter> for some reason.

I was able to restart the machine after syncing the drive but my restart
ended up with lost interrupt messages and literally hung on the hde
partition check.

I literally had to unplug the machine for awhile and then restart it to
continue.

Once rebooted everything is lightning fast again.


Can anyone tell me what this warning/error message really means and how I
might go about tracking this down myself.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
