Message-ID: <37DEF583.3DC2F0D4@ctam.com.au>
Date: Wed, 15 Sep 1999 11:25:23 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc8xx-2.3.10 configuration questions.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have managed to compile a zImage for the BSE target.  Great.  It took
a lot of trial and error to find out which options to leave out.  The
serial and serial-console support is an obvious one which seems natural
to include but causes the build to fail.

It fails to build if I include any of the following options.  I can't
remember the exact error messages but can post them later if it helps.
* CPU is too slow to handle full bandwidth.
* MS-DOS, VFAT filesystems.
* SMB network filesystems.

Has anyone had similar problems ?  Must other options be included for
any of these to work ?

I notice that the .config file has both 8xx and 6xx cpus defined even
though I've chosen 8xx/860.  Similarly, CONFIG_PARIDE_PARPORT=y even
though I don't enable it.  It looks as though there are some defaults
that are set regardless of what the user sets.  This worries me a bit,
especially having 8xx and 6xx cpus both defined.  Is this intentional ?

Thanks,
Brendan Simon.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
