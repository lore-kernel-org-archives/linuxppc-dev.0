Message-ID: <37DFF342.94EE3B8@jlc.net>
Date: Wed, 15 Sep 1999 15:28:02 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: bsimon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.3.10 configuration questions.
References: <37DEF583.3DC2F0D4@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan Simon wrote:

> It fails to build if I include any of the following options.  I can't
> remember the exact error messages but can post them later if it helps.
> * CPU is too slow to handle full bandwidth.

The cpu isn't too slow, so don't select this one.

> * MS-DOS, VFAT filesystems.
> * SMB network filesystems.

These are the result of generic VM changes and are not at all
related to 8xx.  You can't build them on any PPC machine in that
release.


> I notice that the .config file has both 8xx and 6xx cpus defined even
> though I've chosen 8xx/860.  Similarly, CONFIG_PARIDE_PARPORT=y even
> though I don't enable it.  It looks as though there are some defaults
> that are set regardless of what the user sets.

This has all been corrected in later releases.  I don't think any
of it was 8xx related as I didn't specifically change anything.

> .....This worries me a bit,
> especially having 8xx and 6xx cpus both defined.  Is this intentional ?

Well, you can either worry or fix it and get on with life.  Keep in
mind that the 8xx is really a minimal change to the Linux/PPC baseline.
If something doesn't work on the 8xx, and it is not specific to
the 8xx (like the file system stuff), chances are it doesn't work
for any PPC release.  Build it for a PMAC or something (you do have
some other PPC besides the 8xx, right?) and compare the results.
Remember, the 2.3.x CVS is a serious development tree, changing
every minute, and can go for many releases without running
properly in many aspects.  When you play in this sandbox you have
to expect things not to work correctly, and contribute to the
updates.

People have full multi-user, multiple network, PPP, web server
stuff running on 8xx platforms....and I never saw them post a
message to any of the PPC lists.....unfortunately no code updates
were posted either....


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
