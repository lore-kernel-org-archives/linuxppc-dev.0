Message-ID: <399A381C.BBBB65F5@ncal.verio.com>
Date: Tue, 15 Aug 2000 23:43:40 -0700
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: xmms patch (was Re: CDDA playback on Pismo (and other newer models) 
Content-Type: multipart/mixed;
 boundary="------------D7A1E0FA8DE5F573F3366EE7"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------D7A1E0FA8DE5F573F3366EE7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



While waiting for the Pismo to get back from the shop,
I went ahead and made the xmms patches for the side-effect
problems using the old x86 system. These should
improve stability when using the xmms_CdRead CDDA
playback plugin. The attached patch is against
xmms-1.2.2, though the affected code is
probably the same in the earlier 1.2 versions.

If trying this out, don't forget to also test Takashi
Oe's patches to fix the endiness and sign problems
in the esd output plugin:

http://lists.linuxppc.org/listarcs/linuxppc-dev/200008/msg00215.html

Once these have some testing, I'll post them on the xmms
patches forum.

There are memory leaks in xmms, so don't be shocked if
it has some serious memory bloat while playing a CD.

Henry
--------------D7A1E0FA8DE5F573F3366EE7
Content-Type: application/octet-stream;
 name="xmms.diff.bz2"
Content-Disposition: attachment;
 filename="xmms.diff.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWfzYeE0ABuvfgGA4YH///zOnnou/797KUAQ+AAAAADmmJkyaMJgmJpgEwCGC
MCMBzTEyZNGEwTE0wCYBDBGBGA5piZMmjCYJiaYBMAhgjAjAc0xMmTRhMExNMAmAQwRgRgCo
okJk01Mo2ahPTRPUnlPIamnohtTeianlP0p6m3fbboAbBEoUlFSKJ+xUJhKFD/I3jrH1FDyi
tylV9RU0TLUmQyYhpbbbbbbbkMDYOE3Onba0wxjmlHOKFEUkUVJHORJ7k+YlHl5PHhJ1saOv
tBy9X8btuNNP94xt9A347XN+6HvCdT3EqUmtOH9JbPAPeO9KPpt+f3p0qqqr44BzIVJ5gnsE
9SZFcfBbx89vY7BJ/cj1UMpDZI9YynEYg21OHG3FrjbaVLbdHsTJlySPWOWYg3xvllZVKSpZ
JqSR1DZbbbdt3Vbcb0xolVNBRqErN7HPIbo3T6Cto2D7uVbbcRxtyZNZppbtPw2dDJqPTo3Q
lmdyZFTeNWWiupTekut1qooooqq097uV70krCpWEzrnCjZJPw/QMm/WxrQzwXKGMXm9GrM0c
/TmRJhuxrQzhImv245ENd2JlSXyk18mdM5/Xk7PJbxq4KdA+QqZFFMmmLbi3gJ9Sb4qyugJ2
pKQfiLI+SR3PdbKqqtttqqq2x8MYxjFtttuDRDRJL6aR6FSqnZ3CipZKmpE7kP5STZlPgQ+K
SdqfA2JJqTeQqfFDkwTcGP6ifmJwQ1h5yHBhJTBN6VKTrHQntH6E7wxvG5J6xgn7D2NXee11
D2kegeL56w3CjqHck4pKFfqk701j5BwDRqGg5xU8I2j4DxdInETowJ3iciT92g6TkHMmg0HO
OkfQ7w5R9gofiTrJ1Jr5xrHSh1nn1ifTubK5cYSp4TCZVOYsMTSUaGUwqaHjPEcwn/sPIseA
WElSfMebkH1GpI+0nmHEnSMp5BwSeH5W2W2y22W2tQ6xqOdIjV9yR4EnFrTUPSeocwcR5jxj
tCplX/xdyRThQkPzYeE0
--------------D7A1E0FA8DE5F573F3366EE7--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
