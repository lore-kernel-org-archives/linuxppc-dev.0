Message-ID: <005101bf87cc$cc3b26d0$1dc9a4cd@rtdsp.com>
Reply-To: "Rob Grimm" <rgrimm@rtdsp.com>
From: "Rob Grimm" <rgrimm@rtdsp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Embedded PowerPC750 problem: Kernel slow response from console
Date: Mon, 6 Mar 2000 19:33:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello All,
    We are working on porting linux to an embedded platform based off of the
PowerPC750.
We are using Linux-2.2.13 configured for serial port console (there is a
standard 16550 onboard).  So far, the kernel
appears to boot fine (with networking disabled).  After we get the message
about freeing kernel
memory, it takes about 10 seconds for the bash# prompt to appear.  Once we
get to this
point, it seems like the kernel runs extremely slow.  When we type a letter,
it takes about 10
seconds for the letter to show up on the console ouput.
    I believe it has something to do with the interrupt controller (which we
do not have setup correctly yet).
I have tried both disabling and enabling external interrupts, and get the
same results.  Has anyone
experienced similar problems?  We started off with the kernel configured for
a Prep system
(we later found out that our system is not much like the prep system), and
went
from there.  How does the kernel handle the serial console input if the
interrupt is disabled?  It appears
that the kernel is running fine, I can do an "ls" and "cd" with no problems,
it just takes a long time
to see any results.  Thanks in advance for any help.

Regards,
Rob Grimm

-----------------------------
Rob Grimm
Real-Time Digital
rgrimm@rtdsp.com
732-681-5700 x13
-----------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
