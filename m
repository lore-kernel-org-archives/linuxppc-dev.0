To: "Jean-Denis Boyer" <jdboyer@mediatrix.com>
Cc: "Rod Boyce" <rod_boyce@stratexnet.com>,
	"LinuxPPC-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Creating RAM disks as a non root user. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 Feb 2003 16:24:03 EST."
             <2702075D4DE2B043BF5EB82E9CFAD45B093BBB@mail1.mediatrix.com>
Date: Tue, 04 Feb 2003 22:52:01 +0100
Message-Id: <20030204215206.CA7D2C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <2702075D4DE2B043BF5EB82E9CFAD45B093BBB@mail1.mediatrix.com> you wrote:
>
> Here is the recipe we use to mount ramdisk images without being a root user.
...
> Note that the option 'user' in fstab allows any user to mount/unmount this specific entry.

Just _mounting_ ramdisk images is not the problem...

> You can either create new ramdisk images, or mount already existing ones (very useful!).

...but to create a useful ramdisk image you will usually also have to
create the device nodes in the /dev directory. And this is  something
that  really  _requires_ root permissions (or it would otherwise open
huge security issues).


And from the system administrator's point of view allowing anybody to
mount any images he likes is a serious security issue, too.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If the code and  the  comments  disagree,  then  both  are  probably
wrong."                                                - Norm Schryer

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
