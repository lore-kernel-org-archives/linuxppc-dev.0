Subject: Re: Creating RAM disks as a non root user.
From: Kenneth Johansson <ken@kieraypc01.tn.sw.ericsson.se>
To: Wolfgang Denk <wd@denx.de>
Cc: Jean-Denis Boyer <jdboyer@mediatrix.com>,
	Rod Boyce <rod_boyce@stratexnet.com>,
	LinuxPPC-Embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20030204215206.CA7D2C608E@atlas.denx.de>
References: <20030204215206.CA7D2C608E@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: 05 Feb 2003 11:47:53 +0100
Message-Id: <1044442073.3146.87.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-02-04 at 22:52, Wolfgang Denk wrote:
>
> In message <2702075D4DE2B043BF5EB82E9CFAD45B093BBB@mail1.mediatrix.com> you wrote:
> >
> > Here is the recipe we use to mount ramdisk images without being a root user.
> ...
> > Note that the option 'user' in fstab allows any user to mount/unmount this specific entry.
>
> Just _mounting_ ramdisk images is not the problem...
>
> > You can either create new ramdisk images, or mount already existing ones (very useful!).
>
> ...but to create a useful ramdisk image you will usually also have to
> create the device nodes in the /dev directory. And this is  something
> that  really  _requires_ root permissions (or it would otherwise open
> huge security issues).
>

If you want full control over owner and group on a file by file basis
you can run fakeroot while creating the image/tar or whatever.

I don't know if fakeroot exist anywhere else than in debian but it
should not be hard to port.

--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Tellusborgsvägen  94              Fax: +46 8 404 72 72
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
