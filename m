Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 11 Dec 2003 08:59:29 +0100
From: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Subject: Lost+Found directory (was: self image)
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <158EF4B20EA8C84D9DC71A55216D2E1C066C5C@csy-exchange1.giat.intra>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Your new filesystem is twice as big as the old one, so it  will  have
> more inode blocks etc. Also, you may notice that our filesystem image
> does not contain the (rather large) lost+found firectory.

How come the lost+found directory is large, or even has a single entry
to begin with? I thought it was used by fsck to collect file data lost
due to file system corruption over time; so in a freshly built embedded
image, there shouldn't be any of that. Did I miss something?

Albert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
