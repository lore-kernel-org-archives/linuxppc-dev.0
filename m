MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15045.61890.58237.453470@ipa.ne.mediaone.net>
Date: Sat, 31 Mar 2001 10:03:30 -0500
From: R Shapiro <reshapiro@mediaone.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: new aic7xxx driver DOES NOT WORK with cdrecord
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


A little while ago I reported a puzzling change to scsi behavior in
the 2.4.3 kernels.  I didn't get any explanation of what was going on,
but after burning half a dozen coasters on a scsi CD-R, testing
various kernel configs, I think I finally understand what's happening.
A completely new driver for aic7xxx was introduced in 2.4.3, or
thereabouts, and it just doesn't work for CD-Rs.  For now it's still
possible to load the old driver (CONFIG_SCSI_AIC7XXX_OLD), which I
only just discovered, and this driver works fine.  But according to
the documentation, support for this will supposedly be removed soon.

Who should I report this problem to? Does Adaptec write these linux
drivers or is it done by a volunteer working on his/her own?  Ideally
I'd like to use the newer driver, if it can be made to work properly.
At the very least I'd like to ensure that the old driver isn't removed
before the new one works.

Or is it possible this is a cdrecord issue, and not a driver problem
after all?  That doesn't make sense to me, but I want to consider all
options.

Is anyone using the new aic7xxx driver successfully with cdrecord?


Thanks for any assistance -



--
reshapiro@mediaone.net

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
