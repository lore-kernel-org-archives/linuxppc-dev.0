Date: Mon, 26 Nov 2001 17:33:51 -0800
From: Ira Weiny <iweiny@acm.org>
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: TiBook, 1394, iPod working (sort of  ;-)
Message-Id: <20011126173351.0490058c.iweiny@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This past week I finaly got around to getting up to date with Ben's tree.  I
built everything and except for a myserious hang on boot after upgrading to
MacOS 9.2 everything is working _great_.

So, I decided to check out what could be done with the iPod.  I have an iPod
connecting to Linux as a SBP2 drive.  All we need now for iPod support is
working HFS+.  But I don't know much about that so...

I have 2 questions.

1) How are things with HFS+?  I don't know much but have done some poking
around.  I notice that I can mount the iPod but the files it shows are not
correct.  But I have another HFS+ drive which seems to mount ok?  I have looked
at the volume info and have seen that the iPod version in the volume header is
"05" and the other drive is version "06"?  This seems odd since I would think
the earlier version would be better supported?  But I probably don't know what
I am talking about...

2) Does anyone know if there are any specs on the DB file for the iPod.  I
could work on reverse engineering it but if I could get some specs that would
be nice.  Anyone have inside connections at Apple?  Am I treading on thin ice
with licensing?

Thanks,
Ira Weiny
iweiny@acm.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
