Subject: Re: glibc vs. newlib
From: "Gary D. Thomas" <gary.thomas@mind.be>
To: Darin.Johnson@nokia.com
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: 
	<F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com>
References: 
	<F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com>
Content-Type: text/plain
Date: 04 Apr 2003 16:19:37 -0700
Message-Id: <1049498377.17056.906.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-04-04 at 16:08, Darin.Johnson@nokia.com wrote:
>
> What are the experiences and tradeoffs of using newlib vs. glibc?  I'm targetting 16M board (maybe some 8M), no swap space, and I'm concerned that adding glibc will suck much of this up.  At the same time we'd also like to be able to use off-the-shelf components like dhcpd or telnetd, and are not sure if newlib would give us too many headaches there.

newlib doesn't really have everything you'd want.  You might
look into uclibc or dietlibc as a lighter weight library.

--
.--------------------------------------------------------.
|       Mind: Embedded Linux and eCos Development        |
|--------------------------------------------------------|
| Gary Thomas              email:  gary.thomas@mind.be   |
| Mind ( http://mind.be )  tel:    +1 (970) 229-1963     |
| gpg: http://www.chez-thomas.org/gary/gpg_key.asc       |
'--------------------------------------------------------'


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
