Message-ID: <37AA04D5.DC423FA2@motorola.com>
Date: Thu, 05 Aug 1999 14:40:37 -0700
From: Robert Shaw <robert.shaw@motorola.com>
Reply-To: rshaw@inficad.com
MIME-Version: 1.0
To: bh40@calva.net, LinuxPPC User <linuxppc-user@lists.linuxppc.org>,
        LinuxPPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: New BootX 1.1.2 problems...
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

Thanks for the new version of BootX 1.1.2. However, after trying it,
I've some things to report:

   * Sound works from the extension or the application.
   * The resolution properly switches when booting with the extension.

Ok, that's the good news. Now for the bad news:

   * When using the extension to boot into Linux, once you click the
     Linux button the screen resolution switches to normal, and I
     immediately get a system error of the following:

     Sorry, a system error occured.
     "* BootX Extension"
     error type 11
     To temporarily turn off extensions....blah blah blah.

     The only button is the Restart button, so I click it, and it boots
     into Linux fine. (this is with the G3 Cache profiler extension
     enabled). Now, if I disable the "G3 Cache Profiler" extension, the
     system error does not appear, but it doesn't indicate that my L2
     cache is enabled on the boot screen like it does with the cache
     profiler extension loaded.
   * Now, here's the weird one, no matter what I choose in the kernel
     pop-up, it ALWAYS loads the first on in the list! No matter what.
     This is of course bad. :(

Hope this info is helpful.  If you need anything more, let me know.

Oh, I almost forget, I have a 400MHz, Rev.1, Blue&White G3. You can
check my web page for exact hardware configuration if you need it.

Thanks for all your dedication on this! We truly appreciate it!!!

-- Robert
rshaw@inficad.com
http://www.inficad.com/~rshaw/





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
