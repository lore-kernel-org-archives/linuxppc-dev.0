Date: Wed, 30 Jun 1999 18:11:50 +0200
To: "Charles A. Jolley" <charles.jolley@zeratec.com>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LinuxPPC R5 on PowerBook Series 1999
Message-Id: <19990630181150.008408@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 30, 1999, Charles A. Jolley <charles.jolley@zeratec.com> wrote:

>2.  I thought I might try to get things working, or at least figure out why
>the kernel doesn't boot.  The only issue is I can't get any feedback from
>the kernel on why it dies.  It prints a short message when it first starts
>but then the screen goes dead before I can read it.  Is there another way to
>get that information out?   In fact, since there are no serial ports on this
>machine (just USB...like the iMac), how do I get any feedback from the
>kernel without functioning video? (or an OF interface to help me along,
>which is what I do in my other kernel development...)

Did you try with the "no video driver" option ?

This may also be a backlight problem, Apple love changing the way the
backlight is controlled from one model to the other. You can try
commenting out the backlight control functions in drivers/macintosh/via-pmu.c.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
