Message-Id: <199911140940.BAA29983@easystreet01.easystreet.com>
Date: Sun, 14 Nov 1999 01:40:50 -0800
Subject: Would HFS+ read only capability be useful?
From: "Dave Camp" <dave@thinbits.com>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since HFS+ development seems to be stalled, I was thinking of throwing my 
hat in the ring. Now, before you call me crazy...

I've got the HFS+ spec. I've got code I wrote for MacOS that was going to be
used for a disk repair program I was working on, but has been put on hold
due to a lack of free time to complete it. The code implements objects for
reading/manipulating the bitmap, volume header, both B*Tree's, extent lists,
HFS wrapper volumes, etc. It also has a nice caching system built into it.

There is enough code, I would think, to implement read only data fork access
for HFS+ volumes without much trouble.

Problem is, I don't know anything about Linux coding, or more specifically,
what the API looks like for adding a file system module (or whatever the
proper term is).

Would this be useful? If so, can someone suggest a book or two on coding in
this area of Linux? Also, are there Unicode API's in Linux (since HFS+ uses
Unicode to store filenames)?

Thanks,
Dave

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
