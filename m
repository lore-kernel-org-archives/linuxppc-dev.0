Date: 27 Feb 2002 09:27:26 -0000
Message-ID: <20020227092726.8147.qmail@mailFA9.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RPXLITE 823 problems
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
   I booted Linux 2.4.7 on the the RPX-Lite-823 and ran
overnight tests on it. After running for about 8 hrs it
stops/hangs saying
"nfs: server not responding"

   However when the same tests were run on RPX-Lite-850
they ran for 65hrs without any problems!

   The tests that we ran are,
   1. while true { kernel_compilation }, in one telnet
      window
   2. while true { find / } on the serial console
   3. from the nfs server "ping the rpx-lite-823"
      infinitely
   the above 3 were run in parallel

   But I am able to ping the target (i.e. the rpx). When
i sent a AYT (are you there) query from the telnet window
it responds with a "yes"

   Any idea as to what is happening ? Are there any
differences between 823 and 850 which could cause this.

The board that we are using are RPX-Lite_DW.
Note that this not the MontaVista kernel and no microcode
patches of any kind were applied.


Thanks for any help
Sarnath

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
