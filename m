Message-ID: <37E488DA.1E501487@execpc.com>
Date: Sun, 19 Sep 1999 01:55:22 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: patches: MacOS-like Wallstreet sound in/out controls
Content-Type: multipart/mixed;
 boundary="------------09519BC3A299EDA5C6F5D690"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------09519BC3A299EDA5C6F5D690
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

attached are a set of patches to make sound controls like those in MacOS.  the
first patch is one to add volume/mute button support.  I didn't write this one,
but I think it's a must have for any Wallstreet owner.  And if you want to use
the second patch, it is required.  The second uses the AWACS interrupt to
monitor the in/out ports and mods resources accordingly.  ie, if headphones
attached, speakers turn off.  unplug phones, speakers on.  same with the line-in
port: plug in and line-in becomes input source (mic in the header..?), when
removed, it isn't.

It's a little messy, but works to the extent of testing on my pbg3/300.  Tell me
if you think I should try to get it put in the tree.  Or we all may think having
2 out volumes is better.  never made sense to me. <shrug>

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group
--------------09519BC3A299EDA5C6F5D690
Content-Type: application/x-gzip;
 name="mac-likesoundcontrol.tar.gz"
Content-Disposition: inline;
 filename="mac-likesoundcontrol.tar.gz"
Content-Transfer-Encoding: base64

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
--------------09519BC3A299EDA5C6F5D690--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
