Message-ID: <000f01c48a95$e18e5c20$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>,
	"Embedded Linux PPC list" <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.LNX.4.60.0408241141110.6489@localhost.localdomain>
Subject: Re: value of XIP?  and whether it works with 2.6 kernel?
Date: Wed, 25 Aug 2004 07:22:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>    as i read it from david w's post on the MTD list, XIP has limited
> value since flash is noticeably more expensive than RAM anyway.
>

The main value, I believe, is as part of a rapid boot setup - you can
avoid the decompress and copy phase.

Mark Chambers

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
