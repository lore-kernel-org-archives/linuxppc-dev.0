From: bob@kunk.jriver.com
Message-ID: <19991027030703.28859.qmail@kunk.jriver.com>
Subject: (fwd) Re: Problems compiling ppc kernels. (fwd)
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 26 Oct 1999 22:07:03 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gerd Knorr Wrote:

In lists.linuxppc.dev, you wrote:
> 
> I have been having some real weird problems with compiling 
> kernels for my iMAC.  I have tried kernel versions 2.2.12, 2.3.23, 2.3.21
> And have goten pretty much the same results.

I got 2.3.23 sorta working on my iMac (rev B).  "grep ^C .config" is attached
at the end of this mail.  There are alot of gliches:

  * needs some careful tuning of the config options to get a kernel which
    compiles and links without errors.
  * hfs does'nt compile.
  * other filesystems don't work as modules.
  * usb keyboard needs a (trivial) patch, see below.
  * usb keyboard works only if ADB_KEYBOARD is compiled in too.
  * I have a few keys which don't work at all because they are
    not mapped by usb_kbd_map (that's why the debug printk in the
    patch).
  * I could'nt make the usb mouse work.  usb mouse driver is listed
    in /proc/bus/usb/drivers, the (logitech) mouse is listed in
    /proc/bus/usb/devices, but /proc/misc has no entry for usb mouse.
    gpm does'nt work too.
  * The kernel does'nt survive a "make clean && make vmlinux".
    Starts swapping, gets slower and slower over time.

vger is still at 2.3.18.  usb keyboard does'nt work at all for me.

My default kernel is still 2.2.6 with the old uubsd stack patched in.

  Gerd

-- end of forwarded message --

Reiterating the quote..

  * The kernel doesn't survive a "make clean && make vmlinux".
    Starts swapping, gets slower and slower over time.

I have EXACTLY the same problem in the intel version so this is not
PPC specific...

The 2.2.13 Kernel I'm running seems stable. For best USB keyboard 
performance I run 2.2.6 though....

Bob
-- 
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
