Message-ID: <388D7A4C.91D0E2BC@tiac.net>
Date: Tue, 25 Jan 2000 06:28:28 -0400
From: Patrick Callahan <pac1@tiac.net>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: getservbyname as used in tcpserver ucspi-tcp-0.84 not finding smtp in
 /etc/services
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm attempting an install of qmail using the additional packages
recommended for use with qmail, ucspi-tcp and daemontools.

Everything seems to be up and running.  qmail can send mail via smtp to
my isp just fine, but local mail is fried due to a failure in starting
tcpserver to process requests local smtp requests.   tcpserver fails on
a call to getenvbyname, which is apparently returning a null, when given
smtp and tcp for parameter values.  /etc/services is as provided in
YDL's CS-1.1  I'll probably switch to having qmail-smtpd started from
inetd as a workaround. While I work on getting this particular snag
straightened out.

I'm not' quite prepared to do debugging yet so I've got two questions:
some for this list and one for the users list.

Here's the "dev" questions

is anyone working on tcpserver or the ucpsi package of which it is a
part?  Has anyone encountered situations where calls to getservbyname do
not return valid services listed in /etc/services?

The author of qmail makes statements about the relative security of
qmail vs sendmail, and states that many sites are switching to tcpserver
as a replacement for inetd.  What's the PPC development community's
thoughts on this?  Is he right?,  are any of you moving in that
direction?

-Pat

I also have questions about setting up an appropriate development and
debugging environment.   I figure that's a user issue, unrelated to the
development of Linux so I'll ask in the user list.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
