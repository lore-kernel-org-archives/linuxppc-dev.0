Message-ID: <20000320034345.24572.qmail@web1004.mail.yahoo.com>
Date: Sun, 19 Mar 2000 19:43:45 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: Auto update
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- "James B. Parker" <pajama1@mindspring.com> wrote:
>
> Is there some sort of auto-update feature in Linux?
> Like some program I can run that checks my currently installed
> package
> versions versus what is available and informs me if a newer version
> exists?
> Or should I just memorize the version of every package I have
> installed?

	Get rpmfind.  You can find it at www.rpmfind.org or
ftp://rpmfind.net/linux/yellowdog/champion-1.2/ppc/YellowDog/RPMS/rpmfind-1.4-2.ppc.rpm
might work.
	Then use the following:

for i in `rpm -qa` ; do rpmfind --latest $i ; done

	That's really quick & dirty  :)
	If anyone thinks that this is a bad idea, perhaps if it is a waste of
global resources, then let us know!  I don't know how
resource-intensive rpmfind is.
	I don't understand why people say that RPM can't do automatic
retrievals and updates.  Usually, people compare it to Debian, saying
that Debian can do that and RPM can't.  You can substitute an ftp or
http URL just as easily as a filename, for any of RPM's operations --
getting info, installing, querying, and more.  And RPM can find them
for you in the first place.

=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
