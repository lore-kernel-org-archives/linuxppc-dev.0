Date: Tue, 3 Jun 2003 16:01:33 -0600 (MDT)
From: daRonin <daronin@digimerc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Remote serial console through USB
In-Reply-To: <20030531005832.GA4272@backlot.linas.org>
Message-ID: <Pine.LNX.4.53.0306031553490.5136@daronin.digimerc.com>
References: <20030530113402.B29314@forte.austin.ibm.com>
 <7874ED64-92BD-11D7-A2DA-000A95A0560C@us.ibm.com> <20030530164822.A28086@forte.austin.ibm.com>
 <20030531005832.GA4272@backlot.linas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  I am trying to get remote serial console going through my Keyspan
USB to Serial adapter.

  The machine is single G4 tower, 1Ghz CPU, running 2.4.20-ben10.

  I appended these options to the kernel load time parameters:

  console=ttyUSB0,57600

  The Keyspan adapter works fine in minicom, and dmesg seems to show all
the modules loading. However I get the message:

"  Warning: unable to open an initial console.  "

  After doing some research I discovered that there is a patch for 2.5
kernel that would allow me to accomplish this task.

  Is there any way I can get this going in 2.4?

  Regards,

daRonin

========================================================
Certe, Toto, sentio nos in Kansate non iam adesse


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
