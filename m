Message-ID: <37E496FD.D6DF0713@jlc.net>
Date: Sun, 19 Sep 1999 03:55:41 -0400
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Joseph Garcia <jpgarcia@execpc.com>
CC: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: patches: MacOS-like Wallstreet sound in/out controls
References: <37E488DA.1E501487@execpc.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph Garcia wrote:

> attached are a set of patches to make sound controls like those in MacOS.

Since I was the last one to check in changes to the driver, I have kind of
been nominated to do this again.  I have patches from several people for some
functional updates on new hardware.  I can add these in/out controls if
people really want them.


While I understand the convenience of these in/out controls, I personally don't
like them.  I run a variety of programs that perform these operations for me.
Sometimes I want to run both line out and speakers at the same time, or select
the microphone without having to unplug line in.  I guess the in/out doesn't prevent
me from doing this, just that a change (plug in or out) will cause a configuration
change without my mixer knowing.  If people generally want these, I'll put them
in along with the other changes I am making.



    -- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
