Message-Id: <3.0.3.32.20030121133523.0071127c@hollabaugh.com>
Date: Tue, 21 Jan 2003 13:35:23 -0700
To: brian.auld@adic.com, linuxppc-embedded@lists.linuxppc.org
From: "Dr. Craig Hollabaugh" <craig@hollabaugh.com>
Subject: Re: Need IDE for embedded Linux project
In-Reply-To: <995FF289C9D69747A09E42992644595405B23618@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Option 1: All Native Linux.



Brian,

If your company is really going to use Linux then push for the Linux development station. The time you personally save by not fooling around with vmware and windows cygwin cross tools will pay for the development computer many times over. You probably have an old 233 or 400 celeron box sitting around collecting dust. Compiling the kernel, which you'll rarely do, after you get things running, with take the most time on an old machine. Device drivers compile in seconds on these old machines.

You have a lot to learn: embedding Linux and cross compiling itself shouldn't be underestimated. Adding Win2K into the picture adds another complexity to screw things up.

Bean counters, you mentioned, will listen to this. Management will also listen if you stress that the windows cygwin cross will cost in terms of time and development complexity.

The question you need everyone to answer is cost and efficiency. Having your IT department or CVS requirements dictate type of development stations directly affects schedule and budget. Using Win2K, makes their life easier at your expense and potentially your job performance and product success.

I have this conversation during my seminars and consulting work. I stress the use of samba, samba mounting NT servers, Windows desktops, putty, etc but maintain that the compiling/debugging machine run Linux. You can mix the environments, be successful and effective.

Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
