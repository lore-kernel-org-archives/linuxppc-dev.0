Message-Id: <199906301412.JAA27511@www2.tuckeris.com>
Date: Wed, 30 Jun 1999 09:01:18 -0500
Subject: LinuxPPC R5 on PowerBook Series 1999
From: "Charles A. Jolley" <charles.jolley@zeratec.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all:
    I have not been able to find any data on the status of running Linux on
the new PowerBooks released in May.  I downloaded the standard R5
distribution installer last night, however, and tried to run it.  After
clicking the "Linux" button on BootX, it wrote a few lines to the console
and then the screen appeared to shut off.  The hard drive was still clicking
away, however, so I think the kernel might have still been running.

    So, I have two questions:

1.  Is there anyone else who is working on getting Linux running on these
models or are there any additional updates beyond the R5 distribution that I
should get and try and...

2.  I thought I might try to get things working, or at least figure out why
the kernel doesn't boot.  The only issue is I can't get any feedback from
the kernel on why it dies.  It prints a short message when it first starts
but then the screen goes dead before I can read it.  Is there another way to
get that information out?   In fact, since there are no serial ports on this
machine (just USB...like the iMac), how do I get any feedback from the
kernel without functioning video? (or an OF interface to help me along,
which is what I do in my other kernel development...)

Thanks,
-Charles

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
