Date: Tue, 16 Mar 1999 22:35:42 -0600 (CST)
From: Ken Roberts <ken@worldnet.att.net>
Reply-To: Ken Roberts <ken.r@worldnet.att.net>
To: Tim Perdue <perdue@raccoon.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MAX file size? 2GB?
In-Reply-To: <00a101be6fa9$f5f98840$0b8c5aa5@timnt.weather.net>
Message-ID: <Pine.LNX.3.96.990316223404.351C-100000@danger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Does anyone know what the max file size is on linux 2.2.1? I hit a brick
>>wall with my database at 2GB.
>>
>>Anyway around this?

i'm not exactly sure, but i think it depends on your blocking factor.  also, it
may be your database.  i know that db2 allows for a single large-object binary
of either two or four gigs, so the database can hold multiples.


-------------------------------------------------------------------------------
    Ken Roberts                                      ken.r@worldnet.att.net
                 Oft-times thou feelest like unto a nut,
                     And yet, M'lord, anon, feel'st thou not so.
                 Yon Almond Joy these selfsame nuts doth have,
                     Whereas contrary Mounds doth have them not.
                                 -- William Shakespeare, kind of


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
