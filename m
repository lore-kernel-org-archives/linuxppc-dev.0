Subject: Re: dmasound audio patch
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Bill Fink <billfink@mindspring.com>
Cc: LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>,
	YellowDog Linux General <yellowdog-general@lists.terrasoftsolutions.com>
In-Reply-To: <20020407172358.36f3fd3e.billfink@mindspring.com>
References: <20020407172358.36f3fd3e.billfink@mindspring.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: 08 Apr 2002 12:30:37 +0200
Message-Id: <1018261838.1870.7347.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2002-04-07 at 23:23, Bill Fink wrote:
>
> A friend of mine, Rob Scott, worked up a patch to the dmasound driver
> that fixes some of the PPC endianness issues by doing byte swapping
> in the driver.  He uses it on a Titanium PowerBook, and I am using it
> on a dual 500 MHz G4 with good results.  Before the patch, using xmms
> with the AudioCD Reader plugin, I had to use the esound driver since
> the OSS driver just gave static.  Now I can use the OSS driver directly,
> so there's no need to run the esd daemon.

Must be an old version of xmms? It swaps bytes if necessary since 1.2.5
or so.

> I know this patch probably isn't politically correct, since as I understand
> it Linus doesn't believe that things such as byte swapping should be done
> in the kernel.  But then he lives on a little endian machine and doesn't
> need to mess with dozens of broken audio applications.

What are those apps? In my experience, most apps where sound doesn't
work are simply broken and need to be fixed anyhow, no kernel patch can
help that.

For example, the XMMS cdread plugin needs fixing to convert the data to
native endianness anyway because otherwise the filtering for the XMMS EQ
produces noise again.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
