Subject: Walnut 4xx problem
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: 28 Mar 2003 20:25:44 +0100
Message-Id: <1048879545.29463.195.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I updated my copy if linuxppc_2.4_devel and got a rather strange problem
running it on a walnut card.

The problem is that when using nfs root the mount is ok /sbin/init is
started but then things falls apart init is not even trying to execute
the start script or the rc scripts but start the getty.

I tracked the problem down to changes made on feb 27 but since that
changes was described by diffstat as
 1183 files changed, 87348 insertions(+), 47678 deletions(-)
It was not obvious what was wrong. All I know now is that it works
before feb27 and not after. I was a little surprised that I needed to go
back so long am I the only one seeing problems ??


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 719 70 20
Tellusborgsvägen  90              Fax: +46 8 719 29 45
126 25 Stockholm                  ken@switchboard.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
