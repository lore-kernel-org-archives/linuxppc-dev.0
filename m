Message-ID: <3694C7B8.EF70DF9C@mpifr-bonn.mpg.de>
Date: Thu, 07 Jan 1999 15:42:00 +0100
From: "Albrecht =?iso-8859-1?Q?Dre=DF?=" <ad@mpifr-bonn.mpg.de>
MIME-Version: 1.0
To: bh40@calva.net, LinuxPPC-Dev Liste <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Bogus interrupts: test fix
References: <19990107143718.019579@mail.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> I've updated the 2.2-pre4 test kernel on my web page, it contains a test
> fix for the bogus interrupt problem. Please try it and give me feedback.

Really good! The improvement of ide performance is impressive. The slowdown
effect has gone during ide _reads_ [= almost "normal" response times compared to
Intel/Linux systems], but is still present during ide _writes_ (I tested it with
a program which writes or reads 200 MB with simple read/write calls, so I have
enough time for a login on a 2nd console). BTW, the read transfer speed given by
hdparm (PB G3/300, IBM DYLA 28100) is 7.08 MB/s.

The bogus interrupts are gone _completely_; still 0 after ~1 hour with a lot of
io. LST interrupts are == 1 (one) after the same time.

Yours, and THANKS for your work,

	Albrecht.

-- 
+-----------------------------------------------------------------------------+
| Dr.-Ing. Albrecht Dre\3                                      ----           |
| Max-Planck-Institut f"ur Radioastronomie    |\       /      /o  o\          |
| Technische Abt. Optische Interferometrie    |  \    /      |  /   |         |
| Auf dem H"ugel 69                           |    \ |        \ ---/          |
| D-53121 Bonn (Germany)          ------------+------+-------------------     |
|                                             |    / |                        |
| Phone (+49) 228 525 319                     |  /  /                         |
| Fax   (+49) 228 525 411                     |/   /                          |
| Mail  ad@mpifr-bonn.mpg.de                                                  |
+-------------- electrical engineers do it with less resistance --------------+

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
