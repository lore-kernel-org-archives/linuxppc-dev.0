Message-ID: <022b01c40811$0b6ee620$3cc8a8c0@epro.dom>
From: "Colin Leroy" <colin@colino.net>
To: "challaharikumar" <challaharikumar@tataelxsi.co.in>,
	<linuxppc-dev@lists.linuxppc.org>
References: <001b01c40802$ea7e2970$3401080a@telxsi.com>
Subject: Re: How to get the exact source code from this clone of linux tree:bitkeeper
Date: Fri, 12 Mar 2004 10:04:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> How to get the exact source code from this clone of linux tree..

A good read about bk is here: http://old.lwn.net/2002/0228/a/bk-thing.php3

Basically the two instructions to get a bk tree are:
bk clone -q http://linux.bkbits.net/linux-2.5 linus-2.5
bk -r co -q

later, to update your tree, you have to issue:
bk pull http://linux.bkbits.net/linux-2.5

(if I understood everything correctly, that is)

HTH,
--
Colin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
