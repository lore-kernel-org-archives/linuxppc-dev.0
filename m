Message-ID: <3A8415D2.C7A2322E@inn.ericsson.se>
Date: Fri, 09 Feb 2001 17:07:46 +0100
From: Kenneth Johansson <kenneth.johansson@inn.ericsson.se>
MIME-Version: 1.0
To: Bernhard Reiter <bernhard@intevation.de>,
	"linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: maillist problem ??
References: <494DCF9DBBCCD2118CC00008C75D706906AF761A@esealnt181>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Who did you address this mail to??

I ask as it lookes like you mail me directly without goin thru the mail list and that is strange as I know nothing about the pmac, my knowlage in ppc is only in the embedded
space.


Bernhard Reiter wrote:
>
> Hello Linuxppc Developers,
>
> for some time now I try to get a recent 2.4.x kernel to work
> on my Powerbook (Lombard G3/400MHZ).
>
> 2.4.0-test7 runs fine, but with the latest linux-pmac-devel from
> rsync ppc.linuxcare.com (Paul Mackeras' tree) I have problem in two
> areas:
>         network: the network sometimes drops out, it can be
>         revived  with a restart of the network
>
>         Error Messages: something about NAT dropping untracked messages.
>         I have netfilter configured, but no special rules used at all.
>
>         ppp: even with 2.4.0-test7 I have problems with ppp over the
>         internal modem.
>         I am using pppd-2.4.0 (maybe this is a problem itself)
>         Sometimes the connections just hangs for a couple of seconds.
>         It is not a provider issue as I encounter this with several
>         providers.
>
>         It all runs fine with 2.2.15-pre19.
>
>         ttyS0: If I do not get a connection, the ttyS0 stops working
>         after a couple of attempts. Then I cannot open it even with
>         minicom (V1.82.1).
>
> If you do not have concrete hints on how to attack my problems,
> maybe you can tell me which is a good place to get a newer but
> reliable kernel. (I refrain from messing with the proprietory
> Bitkeeper stuff.)
>
> And were bugs or difficulties like this can be reported proberly.
>
> Thanks,
>         Bernhard
>
> ps.: Please cc relevant replies to me, as I am not subscribed to the
> list.
>
> --
> Professional Service around Free Software                (intevation.net)
> The FreeGIS Project                                         (freegis.org)
> Association for a Free Informational Infrastructure            (ffii.org)
> FSF Europe                                                (fsfeurope.org)

--
Kenneth Johansson
Ericsson Business Innovation AB   Tel: +46 8 404 71 83
Viderögatan 3                     Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@inn.ericsson.se

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
