Subject: Re: Listing wireless access points on an airport card
From: Owen Stampflee <owen@stampflee.com>
To: Corey Minyard <minyard@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3E41F057.3070203@acm.org>
References: <3E41F057.3070203@acm.org>
Message-Id: <1044514529.1287.3608.camel@whitefusion>
Mime-Version: 1.0
Date: 05 Feb 2003 22:56:14 -0800
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I have an iBook2 with an airport card in it, and I was looking for a way
> to list all the access points.  I tried "iwlist eth0 scan", but it
> doesn't seem to be supported.  Is it possible with this card?  It seems
> to work on OS X.  There seems to be some stuff in the driver for this,
> but it seems incomplete.

Theres a patch available that will allow you to put the airport card
into monitor mode, I tried but never got it working but others have.
Google is your friend as I dont have the URL off hand. Then it's simply
a matter of using a sniffing program such as Airsnort or Kismet to list
the local access points.

Owen

--
Owen Stampflee - owen@stampflee.com - http://www.stampflee.com
GnuPG Fingerprint: EDE6 48EC 4E65 BE83 D405  B091 B170 8AF0 F875 65E0
Download My Public Key: http://www.stampflee.com/owen.asc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
