Date: Thu, 11 Dec 2003 10:39:39 +0100
From: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Subject: RE: Lost+Found directory (was: self image)
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <158EF4B20EA8C84D9DC71A55216D2E1C066C5E@csy-exchange1.giat.intra>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> > How come the lost+found directory is large, or even has a
> > single entry to begin with? I thought it was used by fsck
> > to collect file data lost due to file system corruption
> > over time; so in a freshly built embedded image, there
> > shouldn't be any of that. Did I miss something?
>
> When the filesystem is created (by mke2fs) special care is  taken  to
> create a big directory that allows for many entries to be reconnected
> without  need  to  grow  the directory which could be dangerous on an
> already corrupted filesystem. Have a look:
>
> [...]
>
> to "blow up" the lost+found/ directory to allow  for  a  sufficiently
> large   number   of   directory   entries.  Today  mke2fs  does  this
> automagically (and people forget why it needs to be done).

Count me out of there: I didn't have the faintest idea about it to
begin with, let alone forget that idea. :)

However, I was dumb not to think of risking corruption while fsck-ing
the filesystem. :)

Thank you wolfgang for your explanation!

Albert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
