Message-ID: <387ECF9A.AAFC6DBD@execpc.com>
Date: Fri, 14 Jan 2000 01:26:18 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: "Keith W. Shaw" <keithws@fork.yi.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Open firmware booting & atyfb
References: <Pine.NEB.4.21.0001130230090.569-100000@dizzy>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Keith W. Shaw" wrote:
> i've also tried passing various kernel arguements.  my normal
> (bootx) arguement is "video=atyfb:vmode:14,cmode:32"  it appears that it's
> trying to change, but just can't (by the way try vmode:13 for something
> interesting :)

I understand the want to stay with fbdev for glx.  One of these days, I too may
try OF booting.  Anyway, about the white "LCD fire" as some of my friends have
termed it, I recall that occuring often before the MCLK code was added to atyfb
control.  Solution: add a mclk param to your atyfb params.  If that is the
cause, it might clear up.  My wallstreet/300 has a mclk of 100, though some
people have set theirs to 83. (mine does work at 83)  so the new video line
would be "video=atyfb:vmode:14,cmode:32,mclk:100" or 83.

If you'd like to share your expiriences with GLX and OF-booting with me, I would
be grateful.  (I am still using utah-glx with Rage hardware disabled)

Thank you for your time.

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
