Message-ID: <37E72B24.E8E0B143@loomer.com>
Date: Mon, 20 Sep 1999 23:52:24 -0700
From: Hugh Caley <hcaley@loomer.com>
MIME-Version: 1.0
To: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
        linuxppc user <linuxppc-user@lists.linuxppc.org>
Subject: 3.3.5 Feedback
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just thought you would like some feedback, Tom.  I installed the 3.3.5 RPMS on
my Lombard laptop today.

As you mentioned, I can use 15 bpp now.  However, the server will not start if
I use bpp 24; it will start if I use bpp 32, but this has the same problems I
had with that color mode before, i.e. apps like Lyx will not start.

I had been using the patched XF68_FBDev file from Kevin Hendrick's Java site
(I hope I got his name right), which allowed running using bpp 24 and was able
to run those apps I mentioned.

Xconfigurator doesn't seem to work with this machine.  Whenever it goes to
test the X server it errors out saying there is something wrong with the
config.

Let me know if I can tell you anything else.

Hugh

--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
