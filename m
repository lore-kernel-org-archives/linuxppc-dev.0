In-Reply-To: <19991216110123.F5452@bassano.linuxcare.com>
Date: Thu, 16 Dec 1999 21:21:13 +0100
To: "David N. Welton" <davidw@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: xmon stack trace tool
Message-Id: <19991216212113.023939@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Dec 16, 1999, David N. Welton <davidw@linuxcare.com> wrote:

>I wrote a little tool in Python that, when given an xmon stack trace
>on the command line, gives you a list of the equivalment function
>names by sifting through System.map (xmonstacktrace must be run in the
>same directory as System.map).

Now, the great thing would be to have this included in xmon with the
bootloader beeing able to load the System.map along with the kernel. I
think Cort already "prepared" for this in 2.3.x.

Another thing that would be useful: Currently, xmon works in "on-screen"
mode on all PMU-based machines. It would probably be easy to add this
capability to CUDA and other PS/2 like machines. It would be a bit more
difficult for the USB keyboards since a special polling routine should be
added to the OHCI driver, but since the new macs lacks serial ports...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
