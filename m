Date: Mon, 26 Nov 2001 23:19:45 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: TiBook, 1394, iPod working (sort of  ;-)
Message-ID: <20011126231944.E10071@plato.local.lan>
References: <20011126173351.0490058c.iweiny@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011126173351.0490058c.iweiny@acm.org>; from iweiny@acm.org on Mon, Nov 26, 2001 at 05:33:51PM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Nov 26, 2001 at 05:33:51PM -0800, Ira Weiny wrote:
>
> This past week I finaly got around to getting up to date with Ben's tree.  I
> built everything and except for a myserious hang on boot after upgrading to
> MacOS 9.2 everything is working _great_.
>
> So, I decided to check out what could be done with the iPod.  I have an iPod
> connecting to Linux as a SBP2 drive.  All we need now for iPod support is
> working HFS+.  But I don't know much about that so...
>
> I have 2 questions.
>
> 1) How are things with HFS+?  I don't know much but have done some poking

for all appearances its abandoned.  the only sign of anything
happening with it is someone starting a sourceforge account for it,
all this has is the very pre-alpha development code which pretty much
just spews errors and panics the kernel, the same code that was
released about a year ago or so.

> around.  I notice that I can mount the iPod but the files it shows are not
> correct.  But I have another HFS+ drive which seems to mount ok?  I have looked

apple always does HFS+ in a wonky way, they basically create a
ordinary HFS filesystem, then put a huge hidden file with an HFS+
filesystem on it, thier drivers notice this and mount the image rather
then the wrapper.  when you tell linux to mount -t hfs whatever /mnt
you will see the HFS wrapper which won't have anything useful (usually
a README and a couple fake macos system files).

> at the volume info and have seen that the iPod version in the volume header is
> "05" and the other drive is version "06"?  This seems odd since I would think
> the earlier version would be better supported?  But I probably don't know what
> I am talking about...

i don't know much about this, its probably not significant, certainly
not to linux since it has zero support for any revision of HFS+,
outside of the userland hfsplusutils.

> 2) Does anyone know if there are any specs on the DB file for the iPod.  I
> could work on reverse engineering it but if I could get some specs that would
> be nice.  Anyone have inside connections at Apple?  Am I treading on thin ice
> with licensing?

don't hold your breath waiting for apple to help, im sure they want
nothing more then to keep this thing MacOSX only.  if you live in the
US (or other country with questionable laws regarding these matters)
you may well want to consult a lawyer before doing any reverse
engineering, the DMCA (or some other rediculous law) may or may not be
an issue with this.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
